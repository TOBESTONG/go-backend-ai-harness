#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${CODEX_HOME:-$HOME/.codex}"
TARGET_AGENTS_DIR="$TARGET_DIR/agents"
BACKUP_DIR="$TARGET_DIR/backups/$(date +%Y%m%d-%H%M%S)"

install_file() {
  local src="$1"
  local dst="$2"

  if [[ ! -f "$src" ]]; then
    echo "missing source: $src" >&2
    exit 1
  fi

  if [[ -e "$dst" ]]; then
    mkdir -p "$BACKUP_DIR"
    cp -p "$dst" "$BACKUP_DIR/$(basename "$dst")"
    echo "backup: $dst -> $BACKUP_DIR/$(basename "$dst")"
  fi

  mkdir -p "$(dirname "$dst")"
  cp -p "$src" "$dst"
  echo "install: $src -> $dst"
}

install_file "$ROOT_DIR/personal-runtime/AGENTS.md" "$TARGET_DIR/AGENTS.md"
install_file "$ROOT_DIR/personal-runtime/agents/reply.md" "$TARGET_AGENTS_DIR/reply.md"
install_file "$ROOT_DIR/personal-runtime/agents/file-handling.md" "$TARGET_AGENTS_DIR/file-handling.md"

echo "done"
echo "target: $TARGET_DIR"
