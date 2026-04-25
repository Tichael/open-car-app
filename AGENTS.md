<!-- AGENTS.md LIMIT: Keep this file under 200 lines. When updating, remove or compress existing content to stay within the limit. -->

# Context: Open Car App

## Project Role
Flutter mobile app for an ESP32 car controller. BLE when near the car, MQTT (over LTE) when remote. Prototyping phase using a virtual car. `contracts/` is a git submodule with shared protobuf + TOML metadata.

---

## Code Generation

```sh
dart run build_runner build --delete-conflicting-outputs
```

Generated files are **committed**. Re-run only when `contracts/` or `config.toml` changes.

| Source | Output | Builder |
|---|---|---|
| `contracts/**/*.proto` | `lib/generated/**/*.pb.dart` | `ProtoBuilder` |
| `contracts/opencar/cars/*/v1/meta.toml` + `transport.toml` | `lib/cars/<vehicle>/constants.g.dart` | `ConstantsBuilder` |
| `config.toml.example` (+ optional `config.toml`) | `lib/config/mqtt_broker_config.g.dart` | `MqttConfigBuilder` |

**`constants.g.dart`** exposes: `kPlatformId` (CRC32), `kPlatformName`, `kCanBusCount`, BLE UUIDs, MQTT topic templates, `kBlePairingWindowSeconds`, `kBleScanTimeoutSeconds`. Never copy-paste TOML values — always import from the generated file.

**`mqtt_broker_config.g.dart`** exposes: `kMqttBrokerHost/Port`, `kMqttUsername/Password`, `kMqttClientId`, `kDebugServerHost/Port`, `kDebugServerPollingIntervalMs`.

For local dev: `cp config.toml.example config.toml` then fill in credentials. `config.toml` is gitignored and must never be committed.

---

## Architecture

### VehicleDefinition (`lib/models/vehicle_definition.dart`)
Abstract class tying constants, proto types, screen, and stub transport together. Concrete implementations live in `lib/cars/<vehicle>/`. Add to `availableVehiclesProvider` to register a new vehicle.

Key methods: `decodeBasicState(bytes)`, `decodeAdvancedState(bytes)`, `buildDashboard()`, `createStubTransport()`.

### Wire Protocol
`AppToDevice` / `DeviceToApp` envelopes carry vehicle-specific bytes. Receiver decodes using `platform_id`. State fields are `optional` — always **merge** updates: `_masterState.mergeFromMessage(incoming)`.

### Transport (`lib/transport/car_transport.dart`)
```dart
abstract class CarTransport {
  TransportType get transportType; // ble | mqtt | stub | http
  Stream<DeviceToApp> get messages;
  Future<void> send(AppToDevice message);
  void dispose();
}
```
- `ble`/`stub`/`http` — full access (basic + advanced state/commands)
- `mqtt` — basic state/commands only; `advanced_command_bytes` and `system_command` are BLE-only

**Selection order (debug):** HTTP (if `transportPreference == http` in `pairedVehicleProvider`) → BLE (if `BleReady`) → MQTT. HTTP branch is compiled away in release via `kDebugMode`. `vehicleStateProvider` uses `ref.watch(carTransportProvider)` to re-subscribe on transport switch.

### Pairing & connection model
Device advertises **only** while its pairing button is held. The app never scans outside `PairingWizardScreen`.

- **First launch / unpaired**: `AppEntryRouter` shows `PairingWizardScreen`. User holds button → wizard scans → taps Pair → `createBond()` → await `bonded` → `pairedVehicleProvider.notifier.pair(config)` → router rebuilds to dashboard.
- **Subsequent launches**: `bleConnectionProvider` reconnects directly to the saved `bleRemoteId` (no scan). Retries every 5 s on disconnect.
- **HTTP debug path** (debug builds only): wizard offers host/port entry + POST `/pairing` + POST `/pair`; saves config with `transportPreference = http`.
- **Unpair**: overflow menu on dashboard → confirmation dialog → `pairedVehicleProvider.notifier.unpair()` → router returns to wizard.
- **`createBond()` is only called in the wizard** — never in `bleConnectionProvider` or transport. The device controls its pairing window; passive wait avoids spurious second dialogs.

### BLE specifics
- Direct reconnect via `BluetoothDevice.fromId(remoteId)` — no scan after pairing.
- ATT error `0x0F` on `setNotifyValue` → wait passively for `bondState == bonded` (3-minute timeout); do NOT call `createBond()` here.
- `source_device_id`: UUID v4 generated on first launch, persisted via `SharedPreferences` (`getOrCreateDeviceId()`), injected as `bleSourceDeviceIdProvider`. Never hardcode.
- `sendBasicCommand()` / `sendAdvancedCommand()` inject `sourceDeviceId` automatically for BLE/HTTP.

---

## UI Architecture

Entry: `main.dart` loads `PairedVehicleConfig` and device ID at startup, then `AppEntryRouter` routes to `PairingWizardScreen` (unpaired) or `vehicle.buildDashboard()` (paired). Reacts to `pairedVehicleProvider` — unpairing returns to wizard automatically.

**Key providers:**

| Provider | Purpose |
|---|---|
| `availableVehiclesProvider` | All supported vehicles |
| `selectedVehicleProvider` | Computed from `pairedVehicleProvider`; null when unpaired |
| `pairedVehicleProvider` | Source of truth for pairing state (`PairedVehicleConfig?`) |
| `initialPairedVehicleConfigProvider` | Pre-loaded config override injected at startup |
| `bleConnectionProvider` | BLE connection lifecycle (`BleConnecting`/`BleReady`/`BleDisconnected`) |
| `bleSourceDeviceIdProvider` | Stable per-device BLE ID (overridden at startup) |
| `carTransportProvider` | Active transport instance |
| `transportTypeProvider` | Cheap `TransportType` watch for UI gating |
| `vehicleStateProvider` | `VehicleSnapshot` + `sendBasicCommand()` / `sendAdvancedCommand()` |

`VehicleSnapshot` fields (`basicState`, `advancedState`) are typed as `GeneratedMessage`; cast in the vehicle's own screen. Decoded once per message, merged via `mergeFromMessage`.

### Per-vehicle screens (`lib/cars/<vehicle>/screens/`)
Transport gating pattern:
```dart
final isBle = transportType == TransportType.ble ||
              transportType == TransportType.stub ||
              transportType == TransportType.http;
```

Screen sections: **State** (always) | **Advanced State** (isBle) | **Controls** (always) | **Advanced Controls** (isBle).

---

## Project Structure

```
contracts/          # git submodule — protos + TOML metadata
lib/
  generated/        # committed generated protobuf Dart classes
  models/vehicle_definition.dart
  cars/<vehicle>/
    constants.g.dart            # generated constants
    <vehicle>_definition.dart   # VehicleDefinition impl
    stub_transport.dart
    screens/<vehicle>_dashboard.dart
  config/
    mqtt_broker_config.g.dart   # generated MQTT + debug server config
    paired_vehicle_config.dart  # PairedVehicleConfig + TransportPreference
    device_identity.dart        # getOrCreateDeviceId()
  transport/        # car_transport.dart, ble_transport.dart, mqtt_transport.dart, http_transport.dart
  providers/        # selected_vehicle, paired_vehicle, ble_connection, ble_source_device_id,
                    # car_transport, vehicle_state
  screens/
    pairing_wizard_screen.dart  # first-run BLE wizard + HTTP debug path
    vehicle_selection_screen.dart  # legacy, unused
  main.dart         # bootstraps device ID + pairing config, AppEntryRouter
tool/builders/      # open_car_builders build_runner package (proto_builder, constants_builder, mqtt_config_builder)
build.yaml          # wires builders into build_runner
config.toml.example # committed CI defaults
config.toml         # gitignored — real credentials
```

---

## Dev Container

All required tools are pre-installed in the dev container (`.devcontainer/Dockerfile`): Flutter, Android SDK, `protoc`, `protoc-gen-dart`. No manual tool setup is needed after opening the container.
