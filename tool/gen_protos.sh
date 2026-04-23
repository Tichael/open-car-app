#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if ! command -v protoc >/dev/null 2>&1; then
  echo "error: protoc is not installed. Install it first (e.g. apt install protobuf-compiler)." >&2
  exit 1
fi

# Ensure Dart protoc plugin is available on PATH.
dart pub global activate protoc_plugin 21.1.2 >/dev/null
export PATH="$PATH:$HOME/.pub-cache/bin"

if ! command -v protoc-gen-dart >/dev/null 2>&1; then
  echo "error: protoc-gen-dart was not found after activating protoc_plugin." >&2
  exit 1
fi

mkdir -p lib/generated

protoc \
  --proto_path=contracts \
  --dart_out=grpc:lib/generated \
  contracts/opencar/core/v1/system.proto \
  contracts/opencar/core/v1/core.proto \
  contracts/opencar/cars/virtual_car/v1/virtual_car.proto

echo "Proto generation completed: lib/generated"
