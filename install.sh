#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${HOME}/.codex/skills/unity-prototype-workflow"

mkdir -p "${HOME}/.codex/skills"
rm -rf "${TARGET_DIR}"
cp -R "${SCRIPT_DIR}/unity-prototype-workflow" "${TARGET_DIR}"

echo "Installed to ${TARGET_DIR}"
