#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 4 ]]; then
  echo "Usage: run_playmode_tests.sh <project-path> [assembly-names] [results-xml] [log-file]" >&2
  exit 1
fi

PROJECT_PATH="$1"
ASSEMBLIES="${2:-}"
RESULTS_XML="${3:-${TMPDIR:-/tmp}/unity_playmode_results.xml}"
LOG_FILE="${4:-${TMPDIR:-/tmp}/unity_playmode_$(date +%s).log}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UNITY_BIN="$(python3 "$SCRIPT_DIR/resolve_unity.py" --project-path "$PROJECT_PATH")"

ARGS=(
  -batchmode
  -projectPath "$PROJECT_PATH"
  -runTests
  -testPlatform PlayMode
  -testResults "$RESULTS_XML"
  -logFile "$LOG_FILE"
)

if [[ -n "$ASSEMBLIES" ]]; then
  ARGS+=(-assemblyNames "$ASSEMBLIES")
fi

"$UNITY_BIN" "${ARGS[@]}"

echo "PlayMode tests succeeded."
echo "Results: $RESULTS_XML"
echo "Log: $LOG_FILE"
