#!/usr/bin/env python3
from __future__ import annotations

import argparse
import os
import re
import sys
from pathlib import Path


def candidate_from_agent_md(project_path: Path | None) -> str | None:
    if project_path is None:
        return None
    for candidate_dir in (project_path, *project_path.parents[:3]):
        agent_md = candidate_dir / "agent.md"
        if not agent_md.exists():
            continue
        text = agent_md.read_text(errors="ignore")
        match = re.search(r"Unity executable path:\s*(.+)", text)
        if not match:
            continue
        candidate = match.group(1).strip().strip("`")
        if Path(candidate).exists():
            return candidate
    return None


def gather_candidates(project_path: Path | None) -> list[str]:
    candidates: list[str] = []

    for key in ("UNITY_EXECUTABLE", "UNITY_PATH"):
        value = os.environ.get(key)
        if value:
            candidates.append(value)

    from_agent = candidate_from_agent_md(project_path)
    if from_agent:
        candidates.append(from_agent)

    for root in (
        Path("/Applications/Unity"),
        Path("/Applications/Unity/Hub/Editor"),
    ):
        if not root.exists():
            continue
        for unity in sorted(root.glob("**/Unity.app/Contents/MacOS/Unity"), reverse=True):
            candidates.append(str(unity))

    return candidates


def main() -> int:
    parser = argparse.ArgumentParser(description="Resolve a Unity executable path.")
    parser.add_argument("--project-path", help="Optional Unity project path for agent.md lookup.")
    args = parser.parse_args()

    project_path = Path(args.project_path).resolve() if args.project_path else None
    for candidate in gather_candidates(project_path):
        if Path(candidate).exists():
            print(candidate)
            return 0

    print(
        "Could not find a Unity executable. Set UNITY_EXECUTABLE or UNITY_PATH, "
        "or record it in project agent.md.",
        file=sys.stderr,
    )
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
