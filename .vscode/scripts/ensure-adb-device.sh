#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-}"

if ! command -v adb >/dev/null 2>&1; then
  echo "adb is not installed or not on PATH."
  exit 1
fi

connected_count="$(adb devices | awk 'NR > 1 && $2 == "device" { c++ } END { print c + 0 }')"

if [[ "$connected_count" -gt 0 ]]; then
  echo "ADB already has at least one connected device."
  exit 0
fi

if [[ -z "$TARGET" ]]; then
  read -r -p "Enter phone IP:port for adb connect: " TARGET
fi

if [[ -z "$TARGET" ]]; then
  echo "No IP:port provided."
  exit 1
fi

echo "No connected device found. Trying: adb connect $TARGET"
adb connect "$TARGET"

connected_count="$(adb devices | awk 'NR > 1 && $2 == "device" { c++ } END { print c + 0 }')"

if [[ "$connected_count" -gt 0 ]]; then
  echo "ADB device connection available."
  exit 0
fi

echo "adb connect did not produce a usable connected device."
exit 1
