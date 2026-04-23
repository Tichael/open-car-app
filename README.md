# Open Car App

Flutter mobile app for interacting with an ESP32-based car controller over BLE (local) and MQTT (remote).

## Prerequisites

Use the provided dev container — it includes Flutter, the Android SDK, `protoc`, and `protoc-gen-dart` pre-installed.

## Code generation

This project generates Dart code from the `contracts/` git submodule (protobuf schemas and TOML metadata). Generated files are committed, so a normal `flutter build` always works without running codegen first.

You need to regenerate when:
- The `contracts` submodule is updated (`git submodule update`)
- You add a new vehicle platform under `contracts/opencar/cars/`

Run:
```sh
dart run build_runner build --delete-conflicting-outputs
```

This produces:
- `lib/generated/` — Dart classes for all `.proto` files (`AppToDevice`, `DeviceToApp`, `BasicState`, etc.)
- `lib/cars/<vehicle>/constants.g.dart` — typed constants sourced from each vehicle's `meta.toml` and the shared `transport.toml` (platform ID, BLE UUIDs, MQTT topic templates)

Both are driven by a custom `build_runner` builder in `tool/builders/`. Unlike Rust's `build.rs`, Dart has no compiler-integrated codegen hook, so this step is manual. There is no need to run it on every build — only when the contracts change.

## Architecture

Communication between the app and the car controller uses a common protobuf envelope pattern:
- `AppToDevice` / `DeviceToApp` — core transport envelope (platform-agnostic)
- Vehicle-specific state and commands are serialized to `bytes` fields inside the envelope and decoded using the `platform_id` CRC32 from `meta.toml`
- The same wire format is used over both BLE and MQTT
