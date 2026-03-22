#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/skill"
DEST_DIR="$HOME/.claude/skills/claude-cracks-the-whip"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source skill directory not found: $SOURCE_DIR" >&2
  exit 1
fi

if [ -e "$DEST_DIR" ]; then
  read -p "Destination already exists. Overwrite? [y/N] " confirm
  case "$confirm" in
    [yY]|[yY][eE][sS]) ;;
    *)
      echo "Installation cancelled."
      exit 0
      ;;
  esac

  rm -rf "$DEST_DIR"
fi

mkdir -p "$(dirname "$DEST_DIR")"
cp -R "$SOURCE_DIR" "$DEST_DIR"

echo "Skill installed. Restart Claude Code to activate."
