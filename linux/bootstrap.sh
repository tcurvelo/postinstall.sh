#!/bin/bash
# Entry point for a fresh machine setup.
# Usage:
#   ./bootstrap.sh           # Linux: server / headless — macOS: desktop
#   ./bootstrap.sh desktop   # Linux: + flatpak GUI apps
set -euo pipefail

OS="$(uname -s)"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# macOS is a single interactive profile; Linux keeps server/desktop.
if [ "$OS" = "Darwin" ]; then
  PROFILE="${1:-desktop}"
else
  PROFILE="${1:-server}"
fi

echo "=== Post-install setup: $PROFILE ($OS) ==="

# ── 1. System-level setup ─────────────────────────────────────────────────────
# Passwordless sudo (Linux only); SSH key and locales are in site.yml.
echo ">>> System setup..."
bash "$SCRIPT_DIR/system.sh"

# ── 2. Install Ansible ────────────────────────────────────────────────────────
if [ "$OS" = "Darwin" ]; then
  # Bootstrap order: Xcode CLT -> Homebrew -> Ansible.
  if ! xcode-select -p &>/dev/null; then
    echo ">>> Installing Xcode Command Line Tools (follow the GUI prompt)..."
    xcode-select --install || true
    echo "Re-run this script once the Command Line Tools finish installing." >&2
    exit 1
  fi
  if ! command -v brew &>/dev/null; then
    echo "Homebrew not found — install it from https://brew.sh and re-run." >&2
    exit 1
  fi
  if ! command -v ansible-playbook &>/dev/null; then
    echo ">>> Installing Ansible..."
    brew install ansible
  fi
  echo ">>> Ensuring community.general collection..."
  ansible-galaxy collection install community.general
else
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
fi

# ── 3. Run playbook ───────────────────────────────────────────────────────────
echo ">>> Running Ansible playbook ($PROFILE profile)..."
ansible-playbook "$SCRIPT_DIR/site.yml" -e "profile=$PROFILE"

echo ""
echo "=== Done! Run 'exec \$SHELL' or open a new terminal to load your environment. ==="
