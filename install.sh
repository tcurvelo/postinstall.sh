#!/bin/bash
set -euo pipefail

REPO="https://github.com/tcurvelo/postinstall.sh"
DEST="$HOME/.postinstall"

# Install git if missing
if ! command -v git &>/dev/null; then
  if command -v apt &>/dev/null; then
    sudo apt update -y && sudo apt install -y git
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y git
  else
    echo "Cannot install git — unsupported package manager." >&2
    exit 1
  fi
fi

# Clone or update
if [ -d "$DEST/.git" ]; then
  echo ">>> Updating existing repo at $DEST..."
  git -C "$DEST" pull --ff-only
else
  echo ">>> Cloning $REPO to $DEST..."
  git clone "$REPO" "$DEST"
fi

bash "$DEST/linux/bootstrap.sh" "$@"
