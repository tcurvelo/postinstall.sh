# postinstall.sh

My personal post-install automation. Not a general-purpose tool, but feel free to take a peek.

## Linux

### Requirements

- Ubuntu or Fedora
- `git` and `bash` (pre-installed on most distros)

### Usage

**Server / headless:**

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/tcurvelo/postinstall.sh/main/install.sh)
```

**Desktop (adds GUI apps, k8s tools, VPN):**

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/tcurvelo/postinstall.sh/main/install.sh) desktop
```

The repo is cloned to `~/.postinstall`. Re-running the command will pull the latest changes before applying.

### What it does

1. **System setup** (`system.sh`) — passwordless sudo, SSH key generation, locale configuration
2. **Installs Ansible** via `apt` or `dnf` if not already present
3. **Runs the Ansible playbook** (`site.yml`) with the selected profile

### Profiles

| Profile | Includes |
|---|---|
| `server` (default) | Dev tools, Python (via `uv`), Docker, oh-my-zsh, HashiCorp tools |
| `desktop` | Everything in `server` + k8s tools, OpenVPN/OpenConnect, Flatpak GUI apps |

### After installation

Open a new terminal (or run `exec $SHELL`) to load the updated environment.
