# Upgrade Notes

## 2026-02-26

### Added `install.sh` modes

- `./install.sh --check` now runs non-mutating diagnostics.
- `./install.sh --yes` enables non-interactive install behavior where possible.

### Added health diagnostics

- New script: `bin/dotfiles-doctor`.
- New make target: `make doctor`.
- Diagnostics include:
  - `~/.zshenv` and `~/.zshrc` presence/symlink checks
  - zsh parse checks for startup/bootstrap scripts
  - antidote location check
  - `tmux-256color` terminfo check

### Added local zsh override hooks

- `zsh/.zshenv` now sources `~/.zshenv.local` when present.
- `zsh/.zshrc` now sources `~/.zshrc.local` when present.
- Use these for machine-specific settings that should not live in shared dotfiles.

### Behavior notes

- Default `./install.sh` behavior is unchanged: full install still runs with no flags.
- In `--yes` mode, shell switching (`chsh`) is skipped and reported as a manual follow-up.
