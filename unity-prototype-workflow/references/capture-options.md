# Capture Options

Use this reference when the user asks for screenshots, per-frame images, video
recording, or when capture reliability becomes the blocker.

## Decision Guide

- Need a few ordinary screenshots and the project already uses a lightweight
  screenshot helper:
  use `ScreenCapture.CaptureScreenshot(...)` through that helper first.
- Need reliable PNG artifacts from a Play Mode test, especially in batchmode:
  prefer Unity Recorder image sequence.
- Need motion review over several seconds:
  use Unity Recorder movie recording, then inspect the mp4 or a contact sheet.
- Need a custom camera or non-Game-View render:
  consider manual `RenderTexture` capture, but treat it as the escape hatch.

## Option Tradeoffs

### `ScreenCapture.CaptureScreenshot(...)`

Best for:
- small numbers of screenshots
- simple editor or interactive runs
- matching existing repo helpers and tests

Pros:
- smallest amount of code
- easy to understand
- good fit when the repo already wraps it

Cons:
- can be flaky about leaving files behind in graphical batch Play Mode runs
- weaker when the real requirement is “assert that a PNG artifact exists”

### Unity Recorder Image Sequence

Best for:
- prefab galleries
- per-state UI coverage
- short scripted sequences
- tests that need one real PNG per step

Pros:
- usually more reliable in batchmode than plain `ScreenCapture`
- designed to emit image files directly
- cleaner fit than recording a movie and extracting frames later

Cons:
- more setup than a simple screenshot helper
- still editor-only
- can add a little coroutine waiting and recorder lifecycle code

### Unity Recorder Movie

Best for:
- gameplay feel review
- motion tuning
- contact sheets
- “does this feel alive?” questions

Pros:
- best for reviewing continuous motion
- easy to turn into contact sheets
- avoids exploding a long run into many PNGs

Cons:
- not ideal when the output contract is “one image per state”
- extracting exact frames later is extra work

### Manual Camera Plus `RenderTexture`

Best for:
- custom off-screen cameras
- special render targets
- cases where Game View capture is not actually seeing the desired output

Pros:
- maximal control
- can capture things the normal screen-based paths cannot

Cons:
- most code
- easiest path to overengineer
- usually the wrong default for UI or standard gameplay screenshot tests

## UI Screenshot Advice

- Prefer an authored test scene over building the whole harness in code.
- Put the camera, canvas, scaler, background, root container, and optional
  `EventSystem` in the scene.
- For prefab galleries, instantiate one prefab, wait a frame, capture, then
  destroy it.
- Keep setup stable and boring before tuning aesthetics.
