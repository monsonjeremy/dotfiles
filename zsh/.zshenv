# Environment variables only - sourced by ALL zsh instances (including non-interactive)
# Aliases and interactive config belong in .zshrc

export ZSH=~/.oh-my-zsh
export PYENV_ROOT="$HOME/.pyenv"

if [[ -t 0 ]]; then
  export GPG_TTY="$(tty)"
fi

export DOTFILES=$HOME/dotfiles
export STOW_FOLDERS="dotfiles,nvim,kitty,tmux,starship,zsh"

export CLICOLOR=1
export LSCOLORS="GxFxCxDxBxegedabagaced" # Mac OS

# Set default editor to nvim
export EDITOR='nvim'

# Enabled true color support for terminals
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# Tool paths
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/Library/pnpm"

# Keep PATH unique across repeated sourcing.
typeset -U path
# Remove stale path typo from older shells if inherited.
path=(${path:#/Users/jmonson/Library/pnpm})

# PATH (consolidated, skip missing directories to avoid stale entries)
for candidate in \
  "$PYENV_ROOT/bin" \
  "$HOME/miniconda/bin" \
  "$HOME/.antigravity/antigravity/bin" \
  "$HOME/.elixir-install/installs/elixir/1.17.3-otp-27/bin" \
  "$HOME/.elixir-install/installs/otp/27.1.2/erts-15.1.2/bin" \
  "$PNPM_HOME" \
  "/opt/homebrew/opt/openjdk@21/bin" \
  "/opt/homebrew/opt/openjdk@17/bin" \
  "/opt/homebrew/opt/ruby/bin" \
  "/opt/homebrew/opt/gnu-sed/libexec/gnubin" \
  "/opt/homebrew/opt/postgresql@15/bin" \
  "$BUN_INSTALL/bin" \
  "/opt/homebrew/bin" \
  "/opt/homebrew/sbin" \
  "/usr/local/sbin"; do
  [[ -d "$candidate" ]] && path=("$candidate" $path)
done

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -f "$HOME/.rover/env" ]] && source "$HOME/.rover/env"

# Optional machine-local overrides (never committed).
[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"

# Final normalization after optional env scripts mutate PATH.
path=(${(u)path})
export PATH
