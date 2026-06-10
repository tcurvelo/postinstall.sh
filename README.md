# postinstall.sh

My personal post-install automation. Not a general-purpose tool, but feel free to take a peek.

## Linux

### Requirements

- Ubuntu or Fedora
- `bash` and `curl` (pre-installed on most distros)

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

## macOS (Apple Silicon)

### Requirements

Bootstrap order is assumed to be in place: **Xcode Command Line Tools → Homebrew → Ansible**.

- Xcode CLT: `xcode-select --install`
- Homebrew: see <https://brew.sh>

The playbook provisions everything else. macOS is a single interactive profile
(no `server`/`desktop` split), so `bootstrap.sh` always runs the `desktop` profile.

### Usage

```bash
git clone https://github.com/tcurvelo/postinstall.sh ~/.postinstall
cd ~/.postinstall
bash linux/bootstrap.sh
```

`bootstrap.sh` installs Ansible + the `community.general` collection via Homebrew,
then runs `site.yml`, which branches by `ansible_os_family` (`Darwin` on macOS).

### What it installs

| Category | Tools |
|---|---|
| CLI / dev | git, neovim, ripgrep, fzf, tmux, zsh + plugins, mise, codex, … (Homebrew) |
| Python | uv (same as Linux) — manages 3.13/3.12/3.11 + uv tools |
| Go | via `mise` |
| GUI (casks) | kitty, Docker Desktop, VS Code, Obsidian, DBeaver, Dropbox |
| k8s | kubectl, kind, k9s (Homebrew) |
| HashiCorp | terraform, vault, nomad (`hashicorp/tap`) |
| System | `osx_defaults`: disable press-and-hold, fast key repeat |

### Not ported from Linux (no macOS equivalent)

These Linux tasks are intentionally skipped on macOS, not silently dropped — see
the header comment in `linux/tasks/darwin.yml`:

- locale generation (`locale-gen` / `localectl`)
- `update-alternatives` (nvim as vi/vim)
- Docker daemon via systemd + `docker` group (Docker Desktop is a GUI app)
- NetworkManager OpenConnect GUI plugin
- Flatpak / Flathub (GUI apps are Homebrew casks instead)
- passwordless sudo (`system.sh` no-ops on macOS by MDM convention)

### Dry run first

```bash
# syntax check (same as CI)
ansible-playbook --syntax-check -i localhost, -e profile=desktop linux/site.yml

# dry run — shows diffs without changing anything
ansible-playbook -i localhost, --connection=local --check --diff -e profile=desktop linux/site.yml

# apply for real
ansible-playbook -i localhost, --connection=local -e profile=desktop linux/site.yml
```

> Note: `--check` does not run cleanly end-to-end on a virgin machine — this is a
> chained bootstrap (a task installs a tool via shell, a later task uses it). The
> idempotent tasks (Homebrew, osx_defaults) check fine; the shell installers are
> skipped under `--check`, so tasks that depend on them may report errors.
