# Neovim Command Reference

This document tracks custom commands and keymaps defined in this dotfiles repo.

## User Commands

| Command | Description | Source |
| --- | --- | --- |
| `:Browse {path}` | Open a path in Finder. | `lua/config/commands.lua` |
| `:LazySync` | Sync plugins with `lazy.nvim`. | `lua/config/commands.lua` |

## Which-Key Groups

Configured in `lua/plugins/ui.lua`:

| Prefix | Group |
| --- | --- |
| `<leader>9` | 99 AI |
| `<leader>b` | Buffers |
| `<leader>c` | Code |
| `<leader>d` | Delete/Definition |
| `<leader>f` | Files/Format |
| `<leader>g` | Git |
| `<leader>l` | Lint |
| `<leader>n` | Navigation |
| `<leader>p` | Picker/Project |
| `<leader>s` | Search/Replace |
| `<leader>t` | Terminal |
| `<leader>v` | Vim Config |
| `<leader>w` | Write/Workflow |
| `<leader>x` | Execute |

## Global Keymaps

Defined in concern modules under `lua/config/keymaps/*.lua`.

### Core

| Mode | Key | Description |
| --- | --- | --- |
| `n` | `<leader>bs` | Search WORD under cursor |
| `v` | `X` | Delete selection without yanking |
| `n` | `<C-s>` | Save file |
| `n` | `<leader>ww` | Insert wait helper snippet |
| `n` | `<leader>ss` | Insert sinon stub annotation |
| `n` | `<leader>s` | Substitute word under cursor |
| `v` | `<leader>s` | Substitute visual selection |
| `n` | `<C-_>` | Clear search highlight |
| `n` | `<Esc>` | Clear search highlight |
| `n` | `<Space>` | Leader key placeholder (`<Nop>`) |
| `x` | `@` | Run macro over visual range |

### Git and Plugins

| Mode | Key | Description |
| --- | --- | --- |
| `n` | `<leader>ga` | Git fetch all remotes |
| `n` | `<leader>grum` | Git rebase onto `upstream/main` |
| `n` | `<leader>grom` | Git interactive rebase onto `origin/main` |
| `n` | `<leader>ps` | Sync plugins |

### Window, Tabs, and Navigation

| Mode | Key | Description |
| --- | --- | --- |
| `n` | `<leader>ve` | Open vimrc in vertical split |
| `n` | `<leader>q` | Save and close window |
| `n` | `<leader>e` | Reload current buffer |
| `n` | `<S-t>` | Open new tab |
| `n` | `<S-x>` | Delete buffer |
| `n` | `<Tab>` | Next buffer |
| `n` | `<S-Tab>` | Previous buffer |
| `n` | `<leader>n` | Toggle Neo-tree |
| `n` | `<leader>nr` | Reveal current file in Neo-tree |
| `n` | `<leader>np` | Toggle No Neck Pain |
| `n` | `<C-h>` | Move to left split (create if missing) |
| `n` | `<C-j>` | Move to lower split (create if missing) |
| `n` | `<C-k>` | Move to upper split (create if missing) |
| `n` | `<C-l>` | Move to right split (create if missing) |

### Pickers and Search

| Mode | Key | Description |
| --- | --- | --- |
| `n` | `<leader>h` | Smart picker |
| `n` | `<C-p>` | Find files |
| `n` | `<C-e>` | Explorer picker |
| `n` | `<leader>p` | Buffer picker |
| `n` | `<leader>sr` | Open GrugFar search/replace |
| `n,x` | `<leader>sR` | Structural search and replace |

### Clipboard, Delete, and Text Ops

| Mode | Key | Description |
| --- | --- | --- |
| `n` | `L` | Move to end of line |
| `v` | `L` | Move to end of line |
| `o` | `L` | Move to end of line |
| `n` | `H` | Move to start of line |
| `v` | `H` | Move to start of line |
| `o` | `H` | Move to start of line |
| `n` | `c*` | Change next match |
| `n` | `c#` | Change previous match |
| `n` | `d*` | Delete next match |
| `n` | `d#` | Delete previous match |
| `v` | `<leader>p` | Paste without yanking replaced text |
| `n` | `<leader>y` | Yank to system clipboard |
| `v` | `<leader>y` | Yank selection to system clipboard |
| `n` | `<leader>Y` | Yank entire buffer to clipboard |
| `n` | `<leader>d` | Delete without yanking |
| `v` | `<leader>d` | Delete selection without yanking |
| `n` | `,` | Page down |
| `n` | `-` | Page up |
| `n` | `∆` | Move line down |
| `n` | `˚` | Move line up |
| `v` | `∆` | Move selection down |
| `v` | `˚` | Move selection up |

### Terminal and Shell

| Mode | Key | Description |
| --- | --- | --- |
| `n` | `<leader>tt` | Open terminal |
| `t` | `<Esc>` | Exit terminal mode |
| `t` | `jj` | Exit terminal mode |
| `n` | `<leader>xp` | Run current line as bash |
| `v` | `<leader>xp` | Run selection as bash |

## LSP Buffer-Local Keymaps

Defined in `lua/lsp/on_attach.lua` and only active in buffers with an attached LSP client.

| Mode | Key | Description |
| --- | --- | --- |
| `n` | `<leader>dd` | LSP: Go to definition |
| `n` | `<leader>df` | LSP: Go to implementation |
| `n` | `<leader>dt` | LSP: Go to type definition |
| `n` | `<leader>dr` | LSP: List references |
| `n` | `<leader>drr` | LSP: Rename symbol |
| `n` | `<leader>pd` | LSP: Peek definition |
| `n` | `K` | LSP: Hover docs |
| `n` | `<leader>cs` | LSP: Line diagnostics |
| `n` | `<leader>dn` | LSP: Next diagnostic |
| `n` | `<leader>dp` | LSP: Previous diagnostic |
| `n` | `<leader>ca` | LSP: Code action |
| `v` | `<leader>ca` | LSP: Code action |
| `n` | `<leader>fo` | LSP: Format buffer |
| `v` | `<leader>fo` | LSP: Format selection |

## Plugin Keymaps

Additional custom keymaps declared in plugin specs/config:

| Mode | Key | Description | Source |
| --- | --- | --- | --- |
| `n` | `.` | Repeat last change | `lua/plugins/editor.lua` |
| `n` | `<leader>l` | Trigger linting for current file | `lua/plugins/quality.lua` |
| `n,v` | `<leader>f` | Format file or range | `lua/plugins/quality.lua` |
| `n,x,o` | `s` | Flash | `lua/plugins/editor.lua` |
| `n,x,o` | `S` | Flash Treesitter | `lua/plugins/editor.lua` |
| `n` | `<leader>pf` | FFF Find Files | `lua/plugins/editor.lua` |
| `n` | `<leader>pg` | FFF Live Grep | `lua/plugins/editor.lua` |
| `n` | `<leader>pz` | FFF Fuzzy Grep | `lua/plugins/editor.lua` |
| `n` | `<leader>gg` | Lazygit | `lua/plugins/editor.lua` |
| `n` | `<C-/>` | Toggle Terminal | `lua/plugins/editor.lua` |
| `n` | `<leader>ff` | Grep with no regex and show hidden files | `lua/plugins/editor.lua` |
| `n` | `<leader>fg` | Grep | `lua/plugins/editor.lua` |
| `n` | `<leader>fb` | Buffers | `lua/plugins/editor.lua` |
| `n` | `<leader>fh` | Help Tags | `lua/plugins/editor.lua` |
| `n` | `<leader>9f` | 99: Fill in Function | `lua/plugins/99.lua` |
| `n` | `<leader>9fp` | 99: Fill in Function Prompt | `lua/plugins/99.lua` |
| `v` | `<leader>99` | 99: Visual | `lua/plugins/99.lua` |
| `v` | `<leader>9p` | 99: Visual Prompt | `lua/plugins/99.lua` |
| `n,v` | `<leader>9s` | 99: Stop All Requests | `lua/plugins/99.lua` |

## Notes

- Key ownership was cleaned so core navigation/edit maps live in `lua/config/keymaps/*.lua` and plugin-owned maps live in plugin specs/config.
- Plugin mappings can still be lazy-loaded by plugin conditions, but key labels remain discoverable through `which-key`.
