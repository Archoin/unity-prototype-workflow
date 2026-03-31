# unity-prototype-workflow-skill

Codex skill repo for `unity-prototype-workflow`.

The actual skill lives in [`unity-prototype-workflow/`](./unity-prototype-workflow). Install that folder into `~/.codex/skills/` on any machine where you want Codex to use it.

## Install

From the repo root:

```bash
./install.sh
```

That copies `unity-prototype-workflow/` into `~/.codex/skills/unity-prototype-workflow`.

## Update

After pulling new changes:

```bash
./install.sh
```

## Notes

- The skill resolves Unity dynamically through `UNITY_EXECUTABLE`, `UNITY_APP`, `agent.md`, or common macOS install paths.
- The skill is intended for Codex users working on Unity prototypes with scene/prefab/scriptable workflows, Play Mode tests, and screenshot/video review.
