#!/bin/bash
# Entry point for a fresh machine setup.
# Usage:
#   ./bootstrap.sh           # server / headless
#   ./bootstrap.sh desktop   # + flatpak GUI apps
set -euo pipefail

PROFILE="${1:-server}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Post-install setup: $PROFILE ==="

# ── 1. System-level setup ─────────────────────────────────────────────────────
# Passwordless sudo, SSH key, locales — things Ansible should not touch.
echo ">>> System setup..."
bash "$SCRIPT_DIR/system.sh"

# ── 2. Install Ansible ────────────────────────────────────────────────────────
if ! command -v ansible-playbook &>/dev/null; then
  echo ">>> Installing Ansible..."
  if command -v apt &>/dev/null; then
    sudo apt update -y
    sudo apt install -y ansible
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y ansible
  else
    echo "Unsupported package manager — install Ansible manually and re-run." >&2
    exit 1
  fi
fi

# ── 3. Run playbook ───────────────────────────────────────────────────────────
echo ">>> Running Ansible playbook ($PROFILE profile)..."
ansible-playbook "$SCRIPT_DIR/site.yml" -e "profile=$PROFILE"

echo ""
echo "=== Done! Run 'exec \$SHELL' or open a new terminal to load your environment. ==="
