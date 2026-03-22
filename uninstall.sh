#!/bin/bash

set -euo pipefail

DEST_DIR="$HOME/.claude/skills/claude-cracks-the-whip"

if [ ! -d "$DEST_DIR" ]; then
  echo "Skill not installed. Nothing to remove."
  exit 0
fi

read -p "Remove claude-cracks-the-whip skill? [y/N] " confirm
case "$confirm" in
  [yY]|[yY][eE][sS])
    rm -rf "$DEST_DIR"
    echo "Skill removed. Restart Claude Code to complete."
    ;;
esac
