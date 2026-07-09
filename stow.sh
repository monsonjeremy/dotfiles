#!/usr/bin/env zsh

# If invoked as `sh stow.sh`, re-exec in zsh so pushd/popd are available.
[ -n "${ZSH_VERSION:-}" ] || exec zsh "$0" "$@"

set -eu
setopt sh_word_split

if ! command -v stow >/dev/null 2>&1; then
  echo "stow is required but was not found in PATH" >&2
  exit 1
fi

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
dotfiles_dir="${DOTFILES:-$script_dir}"
stow_folders="${STOW_FOLDERS:-dotfiles,nvim,kitty,tmux,starship,zsh}"

pushd "$dotfiles_dir" >/dev/null

old_ifs=$IFS
IFS=','
set -- $stow_folders
IFS=$old_ifs

for folder in "$@"; do
  [ -n "$folder" ] || continue
  # Keep operation idempotent: ignore "not currently stowed" during cleanup.
  stow -D "$folder" >/dev/null 2>&1 || true
  stow "$folder"
done

popd >/dev/null
