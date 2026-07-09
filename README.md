<div align="center">
  My personal dotfiles, which turn a ZSH shell into a full development environment
</div>
<br/>
<br/>

## Table of Contents

- [Installation](#installation)
- [Commands](#commands)
- [Operations](#operations)
- [Local Overrides](#local-overrides)
- [Upgrade Notes](#upgrade-notes)

## Installation

```bash
./install.sh
```

For non-mutating diagnostics:

```bash
./install.sh --check
```

For automation/non-interactive runs:

```bash
./install.sh --yes
```

## Commands

Key command mappings and shell helpers live in:
- `zsh/.zshrc` (aliases and interactive shell config)
- `zsh/.functions` (custom shell functions)

## Operations

- `make doctor` runs dotfiles health checks (symlinks, shell parse checks, antidote path, terminfo).
- `make nvim-smoke` runs headless Neovim invariants (`:Browse`, `:LazySync`, and core keymap expectations).

## Local Overrides

- `~/.zshenv.local` is sourced from `zsh/.zshenv` if present.
- `~/.zshrc.local` is sourced from `zsh/.zshrc` if present.
- Keep machine-specific paths, secrets, or one-off aliases in these local files.

## Local Git Identity

Personal Git identity/signing is loaded from `~/.gitconfig.local`.

Use `dotfiles/.gitconfig.local.example` as a template.

## Upgrade Notes

See `UPGRADE.md` for notable behavior changes and migration notes.
