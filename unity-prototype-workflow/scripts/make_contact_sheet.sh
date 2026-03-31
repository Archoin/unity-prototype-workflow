#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 || $# -gt 4 ]]; then
  echo "Usage: make_contact_sheet.sh <input-video> <output-png> [fps] [tile]" >&2
  exit 1
fi

INPUT_VIDEO="$1"
OUTPUT_PNG="$2"
FPS="${3:-1}"
TILE="${4:-4x2}"
FFMPEG_BIN="${FFMPEG_BIN:-$(command -v ffmpeg)}"

if [[ -z "$FFMPEG_BIN" ]]; then
  echo "ffmpeg is required." >&2
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT_PNG")"

"$FFMPEG_BIN" -y \
  -i "$INPUT_VIDEO" \
  -vf "fps=${FPS},tile=${TILE}:padding=8:margin=8" \
  -frames:v 1 \
  -update 1 \
  "$OUTPUT_PNG"

echo "Contact sheet: $OUTPUT_PNG"
