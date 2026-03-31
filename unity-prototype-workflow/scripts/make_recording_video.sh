#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 || $# -gt 3 ]]; then
  echo "Usage: make_recording_video.sh <frames-dir> <output-mp4> [fps]" >&2
  exit 1
fi

FRAMES_DIR="$1"
OUTPUT_MP4="$2"
FPS="${3:-4}"
FFMPEG_BIN="${FFMPEG_BIN:-$(command -v ffmpeg)}"

if [[ -z "$FFMPEG_BIN" ]]; then
  echo "ffmpeg is required." >&2
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT_MP4")"

"$FFMPEG_BIN" -y \
  -framerate "$FPS" \
  -i "$FRAMES_DIR/frame_%04d.png" \
  -c:v libx264 \
  -pix_fmt yuv420p \
  "$OUTPUT_MP4"

echo "Video: $OUTPUT_MP4"
