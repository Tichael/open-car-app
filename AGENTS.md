# Context: Open Car App

## Project Role
Flutter mobile app for interacting with an ESP32 car controller. Communicates over **BLE** when in close proximity to the car and **MQTT** (over LTE) when remote. Currently in prototyping phase using a virtual car implementation.

The `contracts/` directory is a **git submodule** pointing to the shared protobuf + metadata repository consumed by both this app and the ESP32 firmware.

---

## Code Generation

Code generation is driven by a custom `build_runner` builder located in `tool/builders/`. Run it with:

```sh
dart run build_runner build --delete-conflicting-outputs
```

There is **no compiler-integrated codegen hook** in Dart (unlike Rust's `build.rs`). Generated files are committed so the app always builds in CI without needing to run codegen first. Re-run only when the `contracts` submodule changes.

### What gets generated

| Source | Output | Builder |
|---|---|---|
| `contracts/**/*.proto` | `lib/generated/**/*.pb.dart` | `ProtoBuilder` — shells out to `protoc` |
| `contracts/opencar/cars/*/v1/meta.toml` + `contracts/opencar/core/v1/transport.toml` | `lib/cars/<vehicle>/constants.g.dart` | `ConstantsBuilder` — reads TOML directly |
| `config.toml.example` (+ optional `config.toml` overlay) | `lib/config/mqtt_broker_config.g.dart` | `MqttConfigBuilder` — reads TOML directly |

### Generated constants (`constants.g.dart`)

Each vehicle gets a `constants.g.dart` file containing:
- `kPlatformId` — CRC32 of the platform name; part of the wire format, never hardcode it elsewhere
- `kPlatformName` — human-readable platform identifier string
- `kCanBusCount` — number of CAN buses required by this vehicle
- BLE UUIDs: `kBleServiceUuid`, `kBleAppToDeviceCharacteristicUuid`, `kBleDeviceToAppCharacteristicUuid`
- MQTT topic templates: `kMqttCommandTopicTemplate`, `kMqttDataTopicTemplate`

Never copy-paste values from the TOML files manually — always import from the generated constants file.

### App config (`mqtt_broker_config.g.dart`)

`config.toml.example` is committed and contains placeholder defaults used by CI. It is the builder's declared input, so codegen always runs cleanly without any local setup.

To use real credentials locally, copy the example and fill in your values — the builder will prefer this file over the example:

```sh
cp config.toml.example config.toml
# edit config.toml with real broker host, port, username, password, client_id
dart run build_runner build --delete-conflicting-outputs
```

`config.toml` is gitignored and must never be committed. The generated `lib/config/mqtt_broker_config.g.dart` **is** committed (like all other generated files) so CI builds without needing `config.toml`.

Constants exposed:
- `kMqttBrokerHost` / `kMqttBrokerPort` — broker address
- `kMqttUsername` / `kMqttPassword` — broker credentials
- `kMqttClientId` — substituted into topic templates as `{client_id}`
- `kDebugServerHost` / `kDebugServerPort` — debug HTTP server address (read from `[debug_server]` table)
- `kDebugServerPollingIntervalMs` — how often `HttpCarTransport` polls `GET /state`

Re-run codegen whenever `config.toml` (or `config.toml.example`) changes.

---

## Architecture

### Vehicle definition

Each platform is represented by a `VehicleDefinition` (abstract class in `lib/models/vehicle_definition.dart`). It is the single place that ties a vehicle's generated constants, proto types, screen, and stub transport together:

```dart
abstract class VehicleDefinition {
  String get platformName;
  int get platformId;             // from constants.g.dart — part of the wire format
  int get canBusCount;
  String get mqttCommandTopicTemplate;
  String get mqttDataTopicTemplate;
  String get bleServiceUuid;
  String get bleAppToDeviceCharacteristicUuid;
  String get bleDeviceToAppCharacteristicUuid;

  GeneratedMessage decodeBasicState(List<int> bytes);    // returns vehicle's BasicState
  GeneratedMessage decodeAdvancedState(List<int> bytes); // returns vehicle's AdvancedState

  Widget buildDashboard();              // returns the vehicle-specific screen
  CarTransport? createStubTransport();  // null if no stub is available
}
```

The concrete implementation for each platform lives under `lib/cars/<vehicle>/`. To add a new vehicle, create a new `VehicleDefinition` subclass there and add it to `availableVehiclesProvider`.

### Envelope pattern

The wire protocol uses an opaque payload pattern (defined in `contracts/AGENTS.md`):

- `AppToDevice` / `DeviceToApp` — core envelope, platform-agnostic
- Vehicle-specific messages (`BasicState`, `AdvancedState`, `BasicCommand`, etc.) are serialized to `bytes` and embedded inside the envelope
- The receiver identifies how to decode the bytes using `platform_id`

```dart
// Sending a vehicle command — called from the vehicle's own screen
ref.read(vehicleStateProvider.notifier).sendBasicCommand(
  BasicCommand(doorLock: DoorLockCommand(lock: true)).writeToBuffer(),
);
// sendBasicCommand() takes raw bytes; platformId is sourced from selectedVehicleProvider

// Receiving state — VehicleStateNotifier decodes bytes once via VehicleDefinition:
//   vehicle.decodeBasicState(vs.basicStateBytes)   → BasicState (vehicle-specific)
//   vehicle.decodeAdvancedState(vs.advancedStateBytes) → AdvancedState
// The vehicle's screen then casts at render time (zero deserialization cost):
final basic = snapshot.basicState as BasicState;
final advanced = snapshot.advancedState as AdvancedState;
```

### State merging

Proto state fields are all `optional`, enabling partial updates (e.g. a speed-only update). Always merge incoming updates into a master state object rather than replacing it:

```dart
_masterState.mergeFromMessage(incomingState);
```

### Transport abstraction

BLE and MQTT use the same `AppToDevice`/`DeviceToApp` envelope. All transport implementations must conform to a shared abstract interface so the UI and state layers are transport-agnostic. The virtual car mock transport is the base implementation used for prototyping.

The abstract class lives in `lib/transport/car_transport.dart`:

```dart
abstract class CarTransport {
  TransportType get transportType;  // ble | mqtt | stub | http
  Stream<DeviceToApp> get messages;
  Future<void> send(AppToDevice message);
  void dispose();
}
```

`TransportType` drives what the UI exposes:
- `ble` / `stub` / `http` — full access: basic + advanced state and commands
- `mqtt` — restricted: basic state and commands only

The active transport is provided via `carTransportProvider` (Riverpod). A derived `transportTypeProvider` re-exposes just the `TransportType` so widgets can watch it cheaply. `carTransportProvider` selection order (debug builds): HTTP (if `httpDebugEnabledProvider` is true) → BLE (if `bleConnectionProvider` is `BleConnected`) → MQTT. In release builds the HTTP branch is compiled away via `kDebugMode`. Only one transport is alive at a time: Riverpod disposes the old one automatically when the provider rebuilds. `vehicleStateProvider` uses `ref.watch(carTransportProvider)` (not `ref.read`) so it rebuilds and re-subscribes to the new transport's message stream whenever the transport switches.

### BLE specifics

- Service UUID and characteristic UUIDs are in `constants.g.dart`
- Use the `device_to_app` characteristic (notify) for incoming state and command responses
- Use the `app_to_device` characteristic (write / write-without-response) for outgoing commands
- Use the largest negotiated MTU; protobuf payloads may span multiple ATT packets
- `source_device_id` in `AppToDevice` is required for BLE commands (stable device identifier for controller arbitration)
- Scan by service UUID, not device name. Scan starts automatically after the user selects a vehicle
- After `connectGatt` + `discoverServices`, call `requestMtu(244)` then write the CCCD descriptor on the notify characteristic to enable notifications (Android doesn't do this automatically)
- If a write returns ATT error `0x0F`, call `createBond()` and retry after `BluetoothBondState.bonded`
- `source_device_id` is generated as a UUID v4 on first app launch, persisted in `SharedPreferences` via `getOrCreateDeviceId()` in `lib/config/device_identity.dart`, and injected into the app as `bleSourceDeviceIdProvider`. Never hardcode or configure it manually
- `sendBasicCommand()` / `sendAdvancedCommand()` in `VehicleStateNotifier` inject `sourceDeviceId` automatically when the active transport is BLE or HTTP

### MQTT specifics

- Topics follow the templates in `constants.g.dart`: `opencar/{client_id}/cmd` and `opencar/{client_id}/data`
- `source_device_id` in `AppToDevice` is ignored over MQTT
- Only `basic_command_bytes` can be sent over MQTT; `advanced_command_bytes` and `system_command` are BLE-only

### HTTP debug transport

A debug-only transport (`HttpCarTransport` in `lib/transport/http_transport.dart`) that imitates BLE over a local HTTP server running on the device. Only instantiated when `kDebugMode` is true and the user toggles it on from the dashboard debug section.

- `POST /cmd` — sends an `AppToDevice` envelope (protobuf bytes body); used by `CarTransport.send()`
- `GET /state` — polled on a `Timer.periodic` at `kDebugServerPollingIntervalMs`; response bytes parsed as `DeviceToApp`
- `POST /pairing` — signals the device to open its pairing window
- `POST /pair` — registers this phone; body = raw `sourceDeviceId` bytes
- `POST /clear-bonds` — removes all paired phones from the device

The three pairing methods (`openPairingWindow`, `registerAsPairedPhone`, `clearBonds`) are not on the `CarTransport` abstract interface. Vehicle screens access them by watching `httpCarTransportProvider`, which returns the active `HttpCarTransport` when it is selected, or null otherwise.

Server coordinates are read from the `[debug_server]` TOML table and emitted as `kDebugServerHost`, `kDebugServerPort`, `kDebugServerPollingIntervalMs` by the `MqttConfigBuilder`.

---

## UI architecture

### Vehicle selection

The app starts at `VehicleSelectionScreen` (`lib/screens/vehicle_selection_screen.dart`), which lists all entries from `availableVehiclesProvider`. Tapping a vehicle sets `selectedVehicleProvider` and navigates to `vehicle.buildDashboard()` — the vehicle's own screen.

State management uses **Riverpod**. The key providers are:

| Provider | Type | Purpose |
|---|---|---|
| `availableVehiclesProvider` | `Provider<List<VehicleDefinition>>` | Hardcoded list of all supported vehicles |
| `selectedVehicleProvider` | `StateProvider<VehicleDefinition?>` | The vehicle the user selected; null before selection |
| `bleConnectionProvider` | `NotifierProvider<BleConnectionNotifier, BleConnectionState>` | BLE scan/connect lifecycle; state is `BleScanning`, `BleConnected(device)`, or `BleDisconnected({warning})` |
| `bleSourceDeviceIdProvider` | `Provider<List<int>>` | Stable per-device BLE identifier (UTF-8 bytes); overridden at startup from `SharedPreferences` |
| `carTransportProvider` | `Provider<CarTransport>` | Active transport — `HttpCarTransport` (debug), `BleCarTransport` (BLE), or `MqttCarTransport` (fallback) |
| `transportTypeProvider` | `Provider<TransportType>` | Derived from `carTransportProvider`; widgets watch this to gate BLE-only UI |
| `httpDebugEnabledProvider` | `StateProvider<bool>` | Whether the HTTP debug transport is enabled; toggled from the dashboard debug section |
| `httpCarTransportProvider` | `Provider<HttpCarTransport?>` | Returns the active `HttpCarTransport` when HTTP is selected, null otherwise |
| `vehicleStateProvider` | `NotifierProvider<VehicleStateNotifier, VehicleSnapshot>` | Accumulated vehicle state; exposes `sendBasicCommand()` and `sendAdvancedCommand()` |

`VehicleSnapshot` holds the merged state for the active vehicle. The fields are typed as `GeneratedMessage` so the core provider has no vehicle-specific imports:

```dart
class VehicleSnapshot {
  final GeneratedMessage basicState;    // cast to vehicle's BasicState in its own screen
  final GeneratedMessage advancedState; // cast to vehicle's AdvancedState in its own screen
  final SystemState? system;            // null until first BLE state update
}
```

`VehicleStateNotifier` uses `ref.watch(carTransportProvider)` in `build()` so it re-subscribes whenever the transport switches. It decodes incoming bytes **once per message** via `VehicleDefinition.decodeBasicState` / `decodeAdvancedState`, then merges using `mergeFromMessage`. The vehicle's screen casts at render time with no deserialization overhead:

```dart
final basic = snapshot.basicState as BasicState;
```

Sending a command — the vehicle screen serialises its own proto type and passes raw bytes:

```dart
// Basic command (available over both BLE and MQTT):
ref.read(vehicleStateProvider.notifier).sendBasicCommand(
  BasicCommand(doorLock: DoorLockCommand(lock: true)).writeToBuffer(),
);

// Advanced command (BLE only — check isBle before calling):
ref.read(vehicleStateProvider.notifier).sendAdvancedCommand(
  AdvancedCommand(...).writeToBuffer(),
);
```

`sourceDeviceId` is injected automatically by `VehicleStateNotifier._send()` when the transport type is BLE or HTTP; callers do not set it.

### Per-vehicle screens

Each vehicle owns its dashboard screen under `lib/cars/<vehicle>/screens/`. The screen is free to import the vehicle's proto types and `constants.g.dart` directly — those imports belong here, not in shared code.

Every vehicle screen follows the same transport-aware gating pattern:

```dart
final isBle = transportType == TransportType.ble ||
               transportType == TransportType.stub ||
               transportType == TransportType.http;
```

The screen is split into five conditional sections:

| Section | Visibility | Contents |
|---|---|---|
| **State** | Always | Odometer, driving status |
| **Advanced State** | BLE/stub/http | Speed, gear |
| **Controls** | Always | Door lock/unlock button |
| **Advanced Controls** | BLE/stub/http | Vehicle-specific advanced command widgets |
| **Debug** | `kDebugMode` only | HTTP toggle; pairing buttons (visible only when HTTP is active) |

Basic state/commands are always visible; advanced state/commands are gated behind `isBle`. The debug section is gated by `kDebugMode` and tree-shaken from release builds. Follow this pattern for all future vehicles.

---

## Project Structure

```
contracts/                    # git submodule — protobuf schemas and TOML metadata
config.toml.example           # committed config template; copied to config.toml for local dev
config.toml                   # gitignored — real broker credentials; falls back to example in CI
lib/
  generated/                  # generated protobuf Dart classes (committed)
  models/
    vehicle_definition.dart   # VehicleDefinition abstract class (includes BLE UUID getters)
  cars/
    <vehicle>/
      constants.g.dart        # generated constants from meta.toml + transport.toml (committed)
      <vehicle>_definition.dart  # VehicleDefinition implementation for this vehicle
      stub_transport.dart     # vehicle-specific stub/mock transport (behaves like BLE)
      screens/
        <vehicle>_dashboard.dart  # vehicle-specific dashboard screen
  config/
    mqtt_broker_config.g.dart # generated MQTT connection constants (committed)
    device_identity.dart      # getOrCreateDeviceId() — generates/persists BLE source_device_id
  transport/
    car_transport.dart        # CarTransport abstract class + TransportType enum
    ble_transport.dart        # BleCarTransport — flutter_blue_plus; MTU negotiation, CCCD, bond handling
    mqtt_transport.dart       # MqttCarTransport — generic; accepts topic templates as constructor params
    http_transport.dart       # HttpCarTransport — debug HTTP transport; polling GET /state, POST /cmd, pairing routes
  providers/
    available_vehicles_provider.dart  # (inside selected_vehicle_provider.dart)
    selected_vehicle_provider.dart    # availableVehiclesProvider + selectedVehicleProvider
    ble_connection_provider.dart      # BleConnectionNotifier + BleConnectionState sealed class
    ble_source_device_id_provider.dart # bleSourceDeviceIdProvider — overridden at startup
    car_transport_provider.dart       # carTransportProvider + transportTypeProvider
    http_debug_provider.dart          # httpDebugEnabledProvider (toggle) + httpCarTransportProvider (typed cast)
    vehicle_state_provider.dart       # VehicleSnapshot, VehicleStateNotifier, vehicleStateProvider
  screens/
    vehicle_selection_screen.dart  # entry screen — lists vehicles, navigates to vehicle.buildDashboard()
  main.dart                   # bootstraps device ID and overrides bleSourceDeviceIdProvider
tool/
  builders/                   # local build_runner builder package (open_car_builders)
    lib/src/
      proto_builder.dart      # invokes protoc as a subprocess
      constants_builder.dart  # parses TOML and emits constants.g.dart
      mqtt_config_builder.dart # parses config.toml[.example] and emits mqtt_broker_config.g.dart
build.yaml                    # wires open_car_builders into build_runner for this package
```

---

## Dev Container

All required tools are pre-installed in the dev container (`.devcontainer/Dockerfile`): Flutter, Android SDK, `protoc`, `protoc-gen-dart`. No manual tool setup is needed after opening the container.
