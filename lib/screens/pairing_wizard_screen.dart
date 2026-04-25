import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_car_app/cars/virtual_car/constants.g.dart';
import 'package:open_car_app/config/mqtt_broker_config.g.dart';
import 'package:open_car_app/config/paired_vehicle_config.dart';
import 'package:open_car_app/providers/selected_vehicle_provider.dart';
import 'package:open_car_app/providers/ble_source_device_id_provider.dart';
import 'package:open_car_app/providers/paired_vehicle_provider.dart';
import 'package:open_car_app/transport/http_transport.dart';
import 'package:permission_handler/permission_handler.dart';

// ── Wizard step state machine ─────────────────────────────────────────────────

enum _Step {
  /// Prompt shown before scan starts — user should hold the pairing button.
  prompt,

  /// Actively scanning for the device's BLE advertisement.
  scanning,

  /// Device found; waiting for the user to tap "Pair".
  found,

  /// Bond or HTTP pair in progress.
  pairing,

  /// Fatal error; user can retry.
  error,
}

// ── Screen ────────────────────────────────────────────────────────────────────

class PairingWizardScreen extends ConsumerStatefulWidget {
  const PairingWizardScreen({super.key});

  @override
  ConsumerState<PairingWizardScreen> createState() =>
      _PairingWizardScreenState();
}

class _PairingWizardScreenState extends ConsumerState<PairingWizardScreen> {
  _Step _step = _Step.prompt;
  BluetoothDevice? _foundDevice;
  String _errorMessage = '';

  // Scan countdown
  int _remainingSeconds = kBleScanTimeoutSeconds;
  Timer? _scanTimeoutTimer;
  Timer? _countdownTimer;
  StreamSubscription<List<ScanResult>>? _scanSubscription;

  // HTTP mode (debug only)
  bool _httpMode = false;
  final _hostController = TextEditingController();
  final _portController = TextEditingController(text: '4242');
  bool _httpTesting = false;
  bool _httpPairingWindowOpen = false;
  String _httpTestResult = '';

  @override
  void dispose() {
    _stopScan();
    _hostController.dispose();
    _portController.dispose();
    super.dispose();
  }

  // ── Scan lifecycle ──────────────────────────────────────────────────────────

  Future<void> _startScan() async {
    final granted = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request().then((s) => s.values.every((v) => v.isGranted));

    if (!granted) {
      _setError('Bluetooth permission denied. Grant it in app settings.');
      return;
    }

    if (!mounted) return;

    // Only one vehicle platform for now — use its service UUID.
    final vehicle = ref.read(availableVehiclesProvider).first;

    setState(() {
      _step = _Step.scanning;
      _remainingSeconds = kBleScanTimeoutSeconds;
    });

    FlutterBluePlus.startScan(
      withServices: [Guid(vehicle.bleServiceUuid)],
      timeout: Duration(seconds: kBleScanTimeoutSeconds),
    );

    _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      if (results.isEmpty || _step != _Step.scanning) return;
      final device = results.first.device;
      dev.log('Wizard found device: ${device.remoteId}', name: 'PairingWizard');
      _stopScan();
      if (mounted)
        setState(() {
          _foundDevice = device;
          _step = _Step.found;
        });
    });

    _scanTimeoutTimer = Timer(Duration(seconds: kBleScanTimeoutSeconds), () {
      if (_step == _Step.scanning) {
        _stopScan();
        _setError(
          'No device found. Make sure you are holding the pairing button and '
          'try again.',
        );
      }
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _step != _Step.scanning) return;
      setState(() => _remainingSeconds--);
    });
  }

  void _stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    _scanTimeoutTimer?.cancel();
    _scanTimeoutTimer = null;
    _countdownTimer?.cancel();
    _countdownTimer = null;
    FlutterBluePlus.stopScan();
  }

  // ── BLE pairing ─────────────────────────────────────────────────────────────

  Future<void> _pairBle() async {
    final device = _foundDevice!;
    setState(() => _step = _Step.pairing);

    try {
      dev.log(
        'Wizard: connecting to ${device.remoteId}',
        name: 'PairingWizard',
      );
      await device.connect(autoConnect: false);
      await device.discoverServices();

      // Apparently, createBond() is not required since Android already shows a popup. Maybe it's the cause of the double popups.
      // dev.log('Wizard: requesting bond', name: 'PairingWizard');
      // await device.createBond();

      await device.bondState
          .firstWhere((s) => s == BluetoothBondState.bonded)
          .timeout(Duration(seconds: kBlePairingWindowSeconds));

      dev.log('Wizard: bond complete', name: 'PairingWizard');

      // Disconnect so bleConnectionProvider can own the connection lifecycle
      // after we save the config.
      await device.disconnect();

      final vehicle = ref.read(availableVehiclesProvider).first;
      await ref
          .read(pairedVehicleProvider.notifier)
          .pair(
            PairedVehicleConfig(
              vehicleId: vehicle.platformName,
              bleRemoteId: device.remoteId.toString(),
              transportPreference: TransportPreference.ble,
            ),
          );
      // AppEntryRouter will rebuild to show the dashboard.
    } on TimeoutException {
      _setError(
        'Pairing timed out. Make sure the pairing window is still open on '
        'the device and try again.',
      );
    } on Exception catch (e) {
      _setError('Pairing failed: $e');
    }
  }

  // ── HTTP pairing (debug only) ───────────────────────────────────────────────

  Future<void> _testHttpConnection() async {
    setState(() {
      _httpTesting = true;
      _httpTestResult = '';
    });
    final host = _hostController.text.trim();
    final port = int.tryParse(_portController.text.trim()) ?? 0;
    if (host.isEmpty || port == 0) {
      setState(() {
        _httpTesting = false;
        _httpTestResult = 'Enter a valid host and port.';
      });
      return;
    }
    try {
      final t = HttpCarTransport(
        host: host,
        port: port,
        pollingIntervalMs: kDebugServerPollingIntervalMs,
      );
      // One poll to verify the server is reachable.
      await Future.delayed(const Duration(milliseconds: 600));
      t.dispose();
      setState(() {
        _httpTesting = false;
        _httpTestResult = 'Connected ✓';
      });
    } on Exception catch (e) {
      setState(() {
        _httpTesting = false;
        _httpTestResult = 'Failed: $e';
      });
    }
  }

  Future<void> _openHttpPairingWindow() async {
    final host = _hostController.text.trim();
    final port = int.tryParse(_portController.text.trim()) ?? 0;
    final t = HttpCarTransport(
      host: host,
      port: port,
      pollingIntervalMs: kDebugServerPollingIntervalMs,
    );
    try {
      await t.openPairingWindow();
      if (mounted) setState(() => _httpPairingWindowOpen = true);
    } on Exception catch (e) {
      _setError('Could not open pairing window: $e');
    } finally {
      t.dispose();
    }
  }

  Future<void> _pairHttp() async {
    setState(() => _step = _Step.pairing);
    final host = _hostController.text.trim();
    final port = int.tryParse(_portController.text.trim()) ?? 0;
    final t = HttpCarTransport(
      host: host,
      port: port,
      pollingIntervalMs: kDebugServerPollingIntervalMs,
    );
    try {
      await t.registerAsPairedPhone(ref.read(bleSourceDeviceIdProvider));
      t.dispose();

      final vehicle = ref.read(availableVehiclesProvider).first;
      await ref
          .read(pairedVehicleProvider.notifier)
          .pair(
            PairedVehicleConfig(
              vehicleId: vehicle.platformName,
              bleRemoteId: '',
              transportPreference: TransportPreference.http,
              httpHost: host,
              httpPort: port,
            ),
          );
    } on Exception catch (e) {
      t.dispose();
      _setError('HTTP pairing failed: $e');
    }
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  void _setError(String message) {
    if (!mounted) return;
    setState(() {
      _step = _Step.error;
      _errorMessage = message;
    });
  }

  void _retry() {
    setState(() {
      _step = _Step.prompt;
      _foundDevice = null;
      _errorMessage = '';
      _httpMode = false;
      _httpPairingWindowOpen = false;
      _httpTestResult = '';
    });
  }

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pair Your Vehicle')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: switch (_step) {
            _Step.prompt => _buildPrompt(),
            _Step.scanning => _buildScanning(),
            _Step.found => _buildFound(),
            _Step.pairing => _buildPairing(),
            _Step.error => _buildError(),
          },
        ),
      ),
    );
  }

  Widget _buildPrompt() {
    if (kDebugMode && _httpMode) return _buildHttpForm();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.bluetooth_searching, size: 64),
        const SizedBox(height: 24),
        Text(
          'Hold the pairing button on your vehicle',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'The device will advertise for $kBleScanTimeoutSeconds seconds. '
          'Tap Start when ready.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        FilledButton.icon(
          onPressed: _startScan,
          icon: const Icon(Icons.search),
          label: const Text('Start'),
        ),
        if (kDebugMode) ...[
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => setState(() => _httpMode = true),
            child: const Text('Use HTTP instead (debug)'),
          ),
        ],
      ],
    );
  }

  Widget _buildScanning() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CircularProgressIndicator.adaptive(strokeWidth: 3),
        const SizedBox(height: 24),
        Text(
          'Looking for your vehicle…',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          '$_remainingSeconds s remaining',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        OutlinedButton(
          onPressed: () {
            _stopScan();
            _retry();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget _buildFound() {
    final device = _foundDevice!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.bluetooth_connected, size: 64),
        const SizedBox(height: 24),
        Text(
          'Vehicle found',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          device.remoteId.toString(),
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
        ),
        const SizedBox(height: 32),
        FilledButton.icon(
          onPressed: _pairBle,
          icon: const Icon(Icons.link),
          label: const Text('Pair'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(onPressed: _retry, child: const Text('Cancel')),
      ],
    );
  }

  Widget _buildPairing() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CircularProgressIndicator.adaptive(strokeWidth: 3),
        SizedBox(height: 24),
        Text('Pairing…', textAlign: TextAlign.center),
        SizedBox(height: 8),
        Text(
          'Confirm the pairing request on your phone if prompted.',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.error_outline,
          size: 64,
          color: Theme.of(context).colorScheme.error,
        ),
        const SizedBox(height: 24),
        Text(
          'Pairing failed',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          _errorMessage,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        FilledButton.icon(
          onPressed: _retry,
          icon: const Icon(Icons.refresh),
          label: const Text('Try again'),
        ),
      ],
    );
  }

  // ── HTTP form (debug only) ──────────────────────────────────────────────────

  Widget _buildHttpForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'HTTP Debug Transport',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Enter the address of the device HTTP server.'),
          const SizedBox(height: 20),
          TextField(
            controller: _hostController,
            decoration: const InputDecoration(
              labelText: 'Host',
              hintText: '192.168.1.100',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _portController,
            decoration: const InputDecoration(
              labelText: 'Port',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: _httpTesting ? null : _testHttpConnection,
            child: _httpTesting
                ? const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                  )
                : const Text('Test Connection'),
          ),
          if (_httpTestResult.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              _httpTestResult,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: _openHttpPairingWindow,
            child: Text(
              _httpPairingWindowOpen
                  ? 'Pairing window open ✓'
                  : 'Open Pairing Window on Device',
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _httpPairingWindowOpen ? _pairHttp : null,
            icon: const Icon(Icons.link),
            label: const Text('Pair'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => setState(() => _httpMode = false),
            child: const Text('Back to BLE'),
          ),
        ],
      ),
    );
  }
}
