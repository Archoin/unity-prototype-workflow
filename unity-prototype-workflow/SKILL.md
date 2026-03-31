---
name: unity-prototype-workflow
description: Build and iterate on Unity 2D/3D prototypes with a fast editor-batch-test-visual-review loop. Use when Codex needs to create or tune Unity scenes, prefabs, ScriptableObjects, playtests, screenshot or video capture, or diagnose Unity-specific problems such as prefab serialization loss, asmdef/test setup, batchmode failures, or visually empty gameplay despite working logic.
---

# Unity Prototype Workflow

## Overview

Use this skill for Unity prototype work where the bottleneck is workflow, not raw C# syntax. Favor a repeatable loop: build the smallest stable authored scene, verify it in batchmode, add Play Mode coverage, capture visual artifacts, and tune only after looking at rendered output.

## Default Rules

- Prefer an editor-authored base scene and prefabs over constructing the whole game at runtime.
- Keep runtime scripts responsible for behavior and data application, not for assembling the entire hierarchy.
- Add `Runtime`, `Editor`, and `PlayModeTests` asmdefs early when a project is more than a single script.
- Add visual capture helpers early. Unity prototypes often fail visually while still passing logic assertions.
- Treat screenshots and frame sequences as required evidence for prototype quality, not optional polish.
- If prefab-generated visuals serialize unreliably, add runtime fallbacks for placeholder art rather than blocking on YAML serialization.
- Do not run two Unity batch processes against the same project in parallel.

## Workflow

### 1. Establish The Stable Core

- Decide whether the scene should be mostly editor-authored or generated.
- For prototypes, keep only repeatable content generation in editor scripts.
- Put gameplay constants in ScriptableObjects or serialized fields, not scattered literals.
- If placeholder visuals are procedural, make them available from runtime code as a fallback.

### 2. Set Up The Verification Loop Early

- Run a batch import/compile check before deeper implementation.
- Add Play Mode tests once there is a playable entry scene.
- Add screenshot capture for key states: start, active gameplay, low-time warning, game over.
- For “does this feel alive?” questions, add a short semi-random recording test and inspect a contact sheet or mp4.

Use the bundled scripts:
- `scripts/rebuild_generated_assets.sh` for editor execute-method rebuilds
- `scripts/run_playmode_tests.sh` for test execution
- `scripts/make_recording_video.sh` to turn captured frames into an mp4
- `scripts/make_contact_sheet.sh` to review a run quickly

### 3. Diagnose The Right Layer

- If Unity cannot compile or import, fix package/asmdef/editor issues first.
- If logic passes but visuals are missing, inspect rendered frames before touching gameplay tuning.
- If the game scores points but looks empty, suspect missing renderer references, sprites, sorting order, scale, or camera framing.
- If a generated prefab loses sprite references, stop assuming prefab YAML is trustworthy and add runtime fallback visuals.

Read [references/batchmode-gotchas.md](references/batchmode-gotchas.md) when batchmode, asmdefs, prefab serialization, or test runner behavior becomes the blocker.

### 4. Tune Only After Looking

- Review actual screenshots, contact sheets, or video before changing spawn rates, sizes, or hook motion.
- Tune readability first:
  - hook visible against the background
  - fish silhouettes readable at a glance
  - enough on-screen activity to avoid dead water
  - score and timer readable
- Tune density second:
  - empty frames are worse than slightly crowded frames for early prototypes
  - a calm game still needs visible motion and targets
- Tune reward/pace third.

Read [references/visual-review.md](references/visual-review.md) when deciding whether a prototype looks fun enough to keep iterating.

## Project Conventions

- Prefer:
  - `Assets/Scripts`
  - `Assets/Editor`
  - `Assets/Tests/PlayMode`
  - `Assets/Generated`
- Keep generated assets separate from hand-authored assets.
- Ignore test-runner temp scenes such as `Assets/InitTestScene*.unity`.
- Persist Unity executable location in a project-local note such as `agent.md` when the workspace already uses that convention.

## Trigger Phrases

This skill is a good fit when the user asks for things like:
- “Build the Unity version”
- “Set up prefabs, Scriptables, and a stable scene”
- “Add Play Mode tests”
- “Take screenshots or record a run and inspect it”
- “Why is the Unity version harder than the Godot version?”
- “Tune the prototype until it looks fun”

## Resources

- `scripts/resolve_unity.py`
- `scripts/rebuild_generated_assets.sh`
- `scripts/run_playmode_tests.sh`
- `scripts/make_recording_video.sh`
- `scripts/make_contact_sheet.sh`
- `references/batchmode-gotchas.md`
- `references/visual-review.md`
