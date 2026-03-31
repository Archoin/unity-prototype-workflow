# Unity Batchmode Gotchas

Use this reference when Unity batchmode or generated assets are the blocker.

## Fast triage order

1. Fix compiler and asmdef errors first.
2. Fix package resolution next.
3. Fix editor execute-method failures next.
4. Fix Play Mode runner issues next.
5. Fix screenshot or frame capture issues last.

## Common failure patterns

### Logic works but scene looks empty

- Inspect rendered frames, not only assertions.
- Check sprite references in generated prefabs.
- Check `SpriteRenderer.m_Sprite` in prefab YAML when generated assets are suspicious.
- If gameplay scores advance but fish or hook are invisible, suspect renderer references, scale, sorting order, or missing sprite assets.
- Add runtime placeholder sprite fallback in scripts when prefab serialization is flaky.

### Generated prefab references do not survive

- Do not assume `SaveAsPrefabAsset` will preserve every runtime-assigned object the way you expect.
- Re-open the saved prefab and inspect what actually serialized.
- Prefer runtime fallback assignment for placeholder visuals.
- Keep editor builders for structure and references, not fragile placeholder-art persistence.

### Play Mode tests create temp scenes

- Unity test runner can leave `Assets/InitTestScene*.unity`.
- Ignore or clean them after test runs.
- Add those files to `.gitignore` in prototype projects.

### Screenshot capture fails in batchmode

- Avoid system framebuffer capture assumptions.
- Prefer off-screen `RenderTexture` capture.
- If UI is `ScreenSpaceOverlay`, temporarily switch to camera-backed canvas during capture.

### Batchmode exits with code 1 and little context

- Search the log for:
  - `error CS`
  - `executeMethod`
  - `Scripts have compiler errors`
  - `Exception`
- Always retain the log path in script output.

### Visual output still feels wrong after tests pass

- Tests proving state transitions are not enough.
- Build a short semi-random recording.
- Convert it to a contact sheet.
- Tune only after looking at the visual artifacts.
