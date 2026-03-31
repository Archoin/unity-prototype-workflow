#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: rebuild_generated_assets.sh <project-path> [execute-method]" >&2
  exit 1
fi

PROJECT_PATH="$1"
EXECUTE_METHOD="${2:-ZenFishingAssetBuilder.RebuildAll}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UNITY_BIN="$(python3 "$SCRIPT_DIR/resolve_unity.py" --project-path "$PROJECT_PATH")"
LOG_FILE="${TMPDIR:-/tmp}/unity_rebuild_$(date +%s).log"

"$UNITY_BIN" \
  -batchmode \
  -nographics \
  -projectPath "$PROJECT_PATH" \
  -executeMethod "$EXECUTE_METHOD" \
  -quit \
  -logFile "$LOG_FILE"

echo "Rebuild succeeded."
echo "Unity: $UNITY_BIN"
echo "Log: $LOG_FILE"
