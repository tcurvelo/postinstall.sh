#!/bin/bash
# System-level setup that must happen before Ansible runs.
# Handles passwordless sudo — SSH key and locales are in site.yml.
set -e

[ "$(id -u)" != "0" ] && SUDO="sudo" || SUDO=""

# ── Passwordless sudo ──────────────────────────────────────────────────────────
SUDOER_FILE="/etc/sudoers.d/$USER"
SUDOER_LINE="$USER ALL=(ALL) NOPASSWD:ALL"
if ! $SUDO grep -q "$SUDOER_LINE" "$SUDOER_FILE" 2>/dev/null; then
  echo "$SUDOER_LINE" | $SUDO tee "$SUDOER_FILE" > /dev/null
  $SUDO chmod 0400 "$SUDOER_FILE"
fi
