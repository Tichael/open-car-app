import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_car_app/cars/virtual_car/constants.g.dart';
import 'package:open_car_app/generated/opencar/cars/virtual_car/v1/virtual_car.pb.dart';
import 'package:open_car_app/providers/ble_source_device_id_provider.dart';
import 'package:open_car_app/providers/car_transport_provider.dart';
import 'package:open_car_app/providers/http_debug_provider.dart';
import 'package:open_car_app/providers/vehicle_state_provider.dart';
import 'package:open_car_app/transport/car_transport.dart';

class VirtualCarDashboardScreen extends ConsumerWidget {
  const VirtualCarDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(vehicleStateProvider);
    final transportType = ref.watch(transportTypeProvider);
    final isBle = transportType == TransportType.ble ||
        transportType == TransportType.stub ||
        transportType == TransportType.http;

    final basic = snapshot.basicState as BasicState;
    final advanced = snapshot.advancedState as AdvancedState;
    final system = snapshot.system;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Car'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              kPlatformName,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Basic state ─────────────────────────────────────────────────
          _SectionHeader(title: 'State'),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: [
              _StateTile(
                label: 'Odometer',
                value: '${basic.odometer} km',
                icon: Icons.straighten,
              ),
              _StateTile(
                label: 'Driving',
                value: basic.isDriving ? 'Yes' : 'No',
                icon: Icons.directions_car,
              ),
            ],
          ),

          // ── Advanced state (BLE only) ────────────────────────────────────
          if (isBle) ...[
            const SizedBox(height: 16),
            _SectionHeader(title: 'Advanced State'),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: [
                _StateTile(
                  label: 'Speed',
                  value: '${advanced.speed} kph',
                  icon: Icons.speed,
                ),
                _StateTile(
                  label: 'Gear',
                  value: _gearLabel(advanced.gear),
                  icon: Icons.settings_input_component,
                ),
              ],
            ),
          ],

          // ── Basic controls ───────────────────────────────────────────────
          const SizedBox(height: 24),
          _SectionHeader(title: 'Controls'),
          const SizedBox(height: 8),
          _DoorLockCard(
            locked: basic.areDoorsLocked,
            onToggle: () {
              ref.read(vehicleStateProvider.notifier).sendBasicCommand(
                    BasicCommand(
                      doorLock: DoorLockCommand(lock: !basic.areDoorsLocked),
                    ).writeToBuffer(),
                  );
            },
          ),

          // ── Advanced controls (BLE only) ─────────────────────────────────
          // Placeholder: virtual-car has no advanced commands. Add advanced
          // command widgets here for vehicles that define AdvancedCommand fields.
          if (isBle) ...[
            const SizedBox(height: 16),
            _SectionHeader(title: 'Advanced Controls'),
            const SizedBox(height: 8),
            const _AdvancedControlsPlaceholder(),
          ],

          // ── Debug section (debug builds only) ───────────────────────────
          if (kDebugMode) ...[const SizedBox(height: 24), const _DebugSection()],

          // ── System info ──────────────────────────────────────────────────
          if (system != null) ...[
            const SizedBox(height: 24),
            _SystemInfoRow(
              firmwareVersion: system.firmwareVersion,
              hardwareType: system.hardwareType,
            ),
          ],
        ],
      ),
    );
  }

  static String _gearLabel(AdvancedState_Gear gear) {
    final name = gear.name;
    const prefix = 'GEAR_';
    if (name.startsWith(prefix)) return name.substring(prefix.length);
    return name;
  }
}

// ── Widgets ──────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _StateTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StateTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: colorScheme.primary),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
            Text(value, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}

class _DoorLockCard extends StatelessWidget {
  final bool locked;
  final VoidCallback onToggle;

  const _DoorLockCard({required this.locked, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(
              locked ? Icons.lock : Icons.lock_open,
              color: locked ? colorScheme.primary : colorScheme.outline,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Doors',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  Text(
                    locked ? 'Locked' : 'Unlocked',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onToggle,
              child: Text(locked ? 'Unlock' : 'Lock'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdvancedControlsPlaceholder extends StatelessWidget {
  const _AdvancedControlsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'No advanced controls for this vehicle.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ),
    );
  }
}

class _SystemInfoRow extends StatelessWidget {
  final String firmwareVersion;
  final String hardwareType;

  const _SystemInfoRow({
    required this.firmwareVersion,
    required this.hardwareType,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Firmware: $firmwareVersion  •  Hardware: $hardwareType',
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
}

// ── Debug section ─────────────────────────────────────────────────────────────
// Only compiled into debug builds via kDebugMode guard in the dashboard build().

class _DebugSection extends ConsumerWidget {
  const _DebugSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final httpEnabled = ref.watch(httpDebugEnabledProvider);
    final httpTransport = ref.watch(httpCarTransportProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: 'Debug'),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('HTTP Debug Transport'),
                subtitle: const Text(
                  'Replace BLE with the device HTTP server',
                ),
                value: httpEnabled,
                onChanged: (value) {
                  ref.read(httpDebugEnabledProvider.notifier).state = value;
                },
              ),
              if (httpTransport != null) ...[
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.link),
                  title: const Text('Open Pairing Window'),
                  subtitle: const Text('Signal the device to show pairing UI'),
                  onTap: () => _runAction(
                    context,
                    httpTransport.openPairingWindow,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.phone_android),
                  title: const Text('Register This Phone'),
                  subtitle: const Text('Add this device to the paired list'),
                  onTap: () => _runAction(
                    context,
                    () => httpTransport.registerAsPairedPhone(
                      ref.read(bleSourceDeviceIdProvider),
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.link_off),
                  title: const Text('Clear All Bonds'),
                  subtitle: const Text('Remove all paired phones from device'),
                  onTap: () => _runAction(
                    context,
                    httpTransport.clearBonds,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _runAction(
    BuildContext context,
    Future<void> Function() action,
  ) async {
    try {
      await action();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Done')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
