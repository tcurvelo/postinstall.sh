#!/bin/bash
# System-level setup that must happen before Ansible runs.
# Handles passwordless sudo — SSH key and locales are in site.yml.
set -e

# Passwordless sudo is Linux-only. On macOS (a managed work machine) we skip it:
# MDM policy often forbids it, and the macOS tasks run entirely as the normal
# user (Homebrew refuses root), so no sudo is needed there.
if [ "$(uname -s)" = "Darwin" ]; then
  echo ">>> macOS detected — skipping passwordless sudo setup."
  exit 0
fi

[ "$(id -u)" != "0" ] && SUDO="sudo" || SUDO=""

# ── Passwordless sudo ──────────────────────────────────────────────────────────
SUDOER_FILE="/etc/sudoers.d/$USER"
SUDOER_LINE="$USER ALL=(ALL) NOPASSWD:ALL"
if ! $SUDO grep -q "$SUDOER_LINE" "$SUDOER_FILE" 2>/dev/null; then
  echo "$SUDOER_LINE" | $SUDO tee "$SUDOER_FILE" > /dev/null
  $SUDO chmod 0400 "$SUDOER_FILE"
fi
