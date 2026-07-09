#!/usr/bin/env bash

set -euo pipefail

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"

check_mode=0
yes_mode=0

log() {
  printf '%s\n' "$1"
}

warn() {
  printf 'WARN: %s\n' "$1" >&2
}

die() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

usage() {
  cat <<'EOF'
Usage: ./install.sh [--check] [--yes]

  --check   Run non-mutating environment checks only.
  --yes     Non-interactive mode for automation where possible.
  --help    Show this help text.
EOF
}

run_terminfo_diagnostics() {
  if ! command -v infocmp >/dev/null 2>&1; then
    warn "infocmp not found; skipping terminfo diagnostics"
    return
  fi

  if infocmp tmux-256color >/dev/null 2>&1; then
    log "OK: terminfo entry available: tmux-256color"
  else
    warn "terminfo entry missing: tmux-256color (tmux colors may degrade)"
  fi
}

for arg in "$@"; do
  case "$arg" in
  --check) check_mode=1 ;;
  --yes | -y) yes_mode=1 ;;
  --help | -h)
    usage
    exit 0
    ;;
  *)
    usage
    die "unknown option: $arg"
    ;;
  esac
done

if [ "$check_mode" -eq 1 ]; then
  log "Running non-mutating dotfiles checks..."
  "$script_dir/bin/dotfiles-doctor"
  run_terminfo_diagnostics
  log "Check complete."
  exit 0
fi

log "Starting dotfiles installation..."

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew..."
  if [ "$yes_mode" -eq 1 ]; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    die "brew executable not found after Homebrew installation"
  fi
else
  log "Homebrew already installed"
fi

# 2. Bundle
log "Installing Brewfile dependencies..."
if [ "$yes_mode" -eq 1 ]; then
  NONINTERACTIVE=1 brew bundle --file="$script_dir/Brewfile"
else
  brew bundle --file="$script_dir/Brewfile"
fi

# 3. Stow
log "Stowing dotfiles..."
"$script_dir/stow.sh"

# 4. Mise (Version Management)
log "Setting up mise..."
if ! command -v mise >/dev/null 2>&1; then
  die "mise not found; expected it to be installed by Brewfile"
fi

mise trust "$script_dir/mise.toml"
mise install

# 5. Shell Setup
zsh_path="$(command -v zsh)"
if [ "${SHELL:-}" != "$zsh_path" ]; then
  if [ "$yes_mode" -eq 1 ]; then
    warn "skipping 'chsh -s $zsh_path' in --yes mode; run it manually if needed"
  else
    log "Changing shell to zsh..."
    chsh -s "$zsh_path"
  fi
fi

run_terminfo_diagnostics
log "Installation complete. Restart your terminal."
