# FFF Telescope-Like Layout

## Goal

- Tune `fff.nvim` so its picker layout feels closer to the old Telescope setup, with the prompt at the top.

## Acceptance Criteria

- `fff` uses a top prompt.
- Wide picker layout matches the old Telescope proportions as closely as `fff` supports.
- Existing picker key semantics remain unchanged.
- The updated config formats and loads cleanly.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate old Telescope layout / picker settings
- [x] Design minimal `fff` option changes
- [x] Implement smallest safe slice
- [x] Run verification (format/headless config probe)
- [x] Summarize changes + verification story
- [x] Record lessons (N/A: no user correction or postmortem lesson this turn)
- [x] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Old Telescope config used `prompt_position = 'top'`, `sorting_strategy = 'ascending'`, horizontal layout, width `0.87`, height `0.80`, preview width `0.55`, and `path_display = { 'truncate' }`.
- Current `fff` plugin spec had no `opts`, so it was using upstream defaults including bottom prompt.
- `fff` does not expose Telescope's exact sorting/caret model, so this pass only maps equivalent layout, prompt, and path display knobs.
- Applied `fff` options for prompt icon, top prompt, width `0.87`, height `0.8`, right preview, preview size `0.55`, top-wrapped flex layout below 120 columns, and end truncation for long paths.

## Verification Plan

- Run `stylua --check` on the changed Lua file.
- Run a headless Neovim check requiring `fff`.
- Probe the resolved `fff` config values after startup.

## Results

- Changed `nvim/.config/nvim/lua/plugins/editor.lua`:
  - Added `fff.nvim` `opts` matching the old Telescope layout where possible.
  - Kept existing keymaps untouched.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/plugins/editor.lua` passed.
- `nvim --headless '+lua require("fff")' '+qa'` passed.
- Headless config probe confirmed `prompt_position = "top"`, `width = 0.87`, `height = 0.8`, `preview_position = "right"`, `preview_size = 0.55`, `flex.wrap = "top"`, and `path_shorten_strategy = "end"`.
- The remaining `vim.lsp.set_log_level() is deprecated` message is pre-existing and unrelated.

---

# Neovim Treesitter Injection Error

## Goal

- Stop Neovim from repeatedly reporting `attempt to call method 'range' (a nil value)` from the Treesitter highlighter when injection queries run.

## Acceptance Criteria

- Opening a buffer with Treesitter injections, such as Markdown fenced code blocks, no longer emits the decoration provider error.
- The fix is local to the Neovim config and does not mutate installed plugin files.
- The updated Lua config formats cleanly and passes a headless Neovim load/repro check.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Reproduce the Treesitter injection failure
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Run verification (format/headless/manual repro)
- [x] Summarize changes + verification story
- [x] Record lessons (N/A: no user correction or postmortem lesson this turn)
- [x] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- `nvim-treesitter` is locked at `cf12346a3414fa1b06af75c79faebe7f76df080a`.
- Neovim 0.12 directive handlers receive captures as `table<integer, TSNode[]>`; this installed `nvim-treesitter` code still treats `match[capture_id]` as a single `TSNode`.
- A Markdown fenced code block reproduces the error through the `set-lang-from-info-string!` directive.
- The fix should wrap only the compatibility boundary for these custom predicates/directives.
- Added a local Neovim 0.12 compatibility override for the affected custom `nvim-treesitter` predicates/directives, normalizing capture lists back to the single node shape those handlers expect.
- Documentation check: Neovim's current Treesitter docs define `add_directive()`/`add_predicate()` handlers as receiving `match: table<integer, TSNode[]>`.
- Upstream check: `nvim-treesitter`'s current `master` branch still has the old single-node assumptions and an open issue matching this exact stack. The long-term fix is migrating this config to the rewritten `nvim-treesitter` setup, which is a larger plugin/config migration.

## Verification Plan

- Run `stylua --check` on the changed Lua file.
- Run the Markdown fenced-code repro in headless Neovim.
- Run a basic headless startup check.

## Results

- Changed `nvim/.config/nvim/lua/plugin_configs/nvim-treesitter.lua`:
  - Added a Neovim 0.12-only compatibility shim for `nvim-treesitter` custom predicates/directives.
  - Normalizes capture-list values back to single nodes before calling `vim.treesitter.get_node_text()`.
  - Covers the observed `set-lang-from-info-string!` failure plus the sibling predicates/directives in the same compatibility boundary.
  - Kept the override documented as temporary and limited to the old `nvim-treesitter` branch.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/plugin_configs/nvim-treesitter.lua` passed.
- `nvim --headless /private/tmp/codex-ts-injection.md '+set ft=markdown' '+redraw' '+qa'` passed without the Treesitter decoration provider error.
- `nvim --headless '+lua require("plugin_configs.nvim-treesitter")' '+qa'` passed.
- The remaining `vim.lsp.set_log_level() is deprecated` message is pre-existing and unrelated to this Treesitter failure.

---

# FFF Preview And Explorer Fixes

## Goal

- Restore code highlighting in `fff` previews and make the explorer-style key show hidden directories reliably.

## Acceptance Criteria

- `fff` preview can use treesitter highlight queries before the first file buffer is opened.
- `<C-e>` opens a real explorer that can show hidden directories instead of a file-only approximation.
- The updated Neovim config loads cleanly in a headless check.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Inspect `fff` preview behavior and hidden-path handling
- [x] Implement the smallest safe fix
- [x] Run verification (format/headless/query/keymap probes)
- [x] Summarize changes + verification story
- [x] Record lessons (N/A: no new correction or postmortem lesson this turn)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- `fff` preview already uses treesitter or syntax highlighting in a scratch buffer; there is no clean config hook to swap preview rendering to `bat`.
- `nvim-treesitter` is currently lazy-loaded on `BufRead`, so many query files are unavailable when the picker preview opens before any real buffer load.
- `fff` is a file picker, not a directory explorer, so it cannot surface folders as first-class results on `<C-e>`.
- `snacks.explorer` supports hidden directories directly and can default to `hidden = true`.

## Verification Plan

- Run `stylua --check` on changed Lua files.
- Run a headless Neovim load check.
- Probe treesitter highlight-query availability after startup.
- Inspect the resolved `<C-e>` mapping after startup.

## Results

- Changed `nvim/.config/nvim/lua/plugins/syntax.lua`:
  - Kept `nvim-treesitter` lazy for real buffer loads, but exposed its runtime files and key filetype aliases early in `init` so `fff` preview can resolve TS/JS highlight queries before `BufRead`.
- Changed `nvim/.config/nvim/lua/config/keymaps/search.lua`:
  - Switched `<C-e>` back to `snacks` explorer with `hidden = true` so hidden directories are visible by default.
- Changed `nvim/.config/nvim/lua/plugins/editor.lua`:
  - Re-enabled `snacks` explorer support because `<C-e>` is now a real explorer again.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/config/keymaps/search.lua nvim/.config/nvim/lua/plugins/editor.lua nvim/.config/nvim/lua/plugins/syntax.lua` passed.
- Headless startup with `require("fff")` and `require("snacks")` passed.
- Early highlight-query probe after startup showed `typescript`, `tsx`, and `javascript` queries available before `nvim-treesitter` itself was loaded.
- Direct `fff` preview probe on `/Users/jeremy.monson/Desktop/Joby/web/apps/usr/app/entry.client.tsx` reported `ft=typescriptreact`, `lang=tsx`, `ok=true`, and `hl=true`.

---

# FFF Picker Binding Cleanup

## Goal

- Simplify the migrated picker bindings so they call library commands/APIs directly wherever the upstream behavior matches the intended key semantics.

## Acceptance Criteria

- Plain file-open bindings use `fff` directly instead of thin local wrappers.
- Only bindings that need local adaptation keep helper logic.
- The updated config still loads cleanly in a headless Neovim check.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate the relevant `fff` command/API behavior
- [x] Simplify the keymap implementation
- [x] Run verification (format/headless/keymap probes)
- [x] Summarize changes + verification story
- [x] Record lessons (N/A: no new correction or postmortem lesson this turn)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- `:FFFFind` is appropriate for the plain file picker binding.
- `:FFFFind {query}` is not equivalent to a prefilled picker search; upstream routes non-directory args through `search_and_show()`.
- `fff` still has no native "open from current buffer directory without mutating global indexing root" helper, so the explorer-style binding needs a small adapter.

## Verification Plan

- Run `stylua --check` on the changed Lua file.
- Run a headless Neovim load check.
- Inspect resolved picker mappings after startup.

## Results

- Changed `nvim/.config/nvim/lua/config/keymaps/search.lua`:
  - Replaced the plain file picker binding with direct `:FFFFind` usage.
  - Inlined the smart-picker binding to call `require('fff').find_files({ query = ... })` directly.
  - Reduced the local helper logic to a single current-directory query adapter for `<C-e>`.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/config/keymaps/search.lua` passed.
- `XDG_STATE_HOME=/tmp/codex-nvim-state-fff-clean-load XDG_CACHE_HOME=/tmp/codex-nvim-cache-fff-clean-load nvim --headless '+lua require("fff"); require("snacks")' '+qa'` passed.
- Resolved normal-mode keymaps after startup still match the expected picker bindings:
  - `<leader>h` -> `Smart picker`
  - `<C-p>` -> `Find files`
  - `<C-e>` -> `Explorer picker`
  - `<leader>p` -> `Buffer picker`
  - `<leader>ff` -> `Grep with no regex and show hidden files`
  - `<leader>fg` -> `Grep`
  - `<leader>fb` -> `Buffers`
  - `<leader>fh` -> `Help Tags`

---

# FFF Picker Migration

## Goal

- Switch the main Neovim picker mappings from `snacks` to `fff` while keeping the existing key layout intact.

## Acceptance Criteria

- Existing picker-facing keys still work on the same bindings after the migration.
- File/grep/explorer-style mappings use `fff` instead of `snacks`.
- Buffer/help mappings remain available on their existing keys without regressing core behavior.
- The updated config loads cleanly in a headless Neovim check.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: config-only migration; used headless load and keymap inspection instead)
- [x] Run verification (format/headless/keymap probes)
- [x] Summarize changes + verification story
- [x] Record lessons (N/A: no new correction or postmortem lesson this turn)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Current picker mappings are split between `config/keymaps/search.lua` and plugin-level `keys` in `plugins/editor.lua`, with at least one conflicting `<leader>p` definition.
- `fff` natively covers file search and live grep, and supports initial queries.
- `fff` does not provide native buffer/help pickers, so the minimal migration keeps those bindings on `snacks` while moving file/grep/explorer-style flows to `fff`.
- `fff` mutates its global indexing base path when opened with `cwd`, so the explorer-style mapping should seed a relative-directory query instead of calling `find_files_in_dir()`.

## Verification Plan

- Run `stylua --check` on changed Lua files.
- Run a headless Neovim load check.
- Inspect the resolved normal-mode mappings for the migrated keys.

## Results

- Changed `nvim/.config/nvim/lua/config/keymaps/search.lua`:
  - Centralized picker/search bindings in one file.
  - Moved `<leader>h`, `<C-p>`, `<C-e>`, `<leader>ff`, and `<leader>fg` to `fff`.
  - Kept `<leader>p`, `<leader>fb`, and `<leader>fh` available via `snacks` because `fff` has no native buffer/help picker.
- Changed `nvim/.config/nvim/lua/plugins/editor.lua`:
  - Removed the duplicated `fff` picker keys (`<leader>p`, `<leader>pg`, `<leader>pz`) from the plugin spec.
  - Removed `snacks` picker key definitions from the plugin spec so key ownership lives in `search.lua`.
  - Dropped `snacks` explorer enablement because explorer-style navigation now uses `fff`.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/config/keymaps/search.lua nvim/.config/nvim/lua/plugins/editor.lua` passed.
- `XDG_STATE_HOME=/tmp/codex-nvim-state-fff XDG_CACHE_HOME=/tmp/codex-nvim-cache-fff nvim --headless '+lua require("fff"); require("snacks")' '+qa'` passed.
- Resolved normal-mode keymaps after startup:
  - `<leader>h` -> `Smart picker`
  - `<C-p>` -> `Find files`
  - `<C-e>` -> `Explorer picker`
  - `<leader>p` -> `Buffer picker`
  - `<leader>ff` -> `Grep with no regex and show hidden files`
  - `<leader>fg` -> `Grep`
  - `<leader>fb` -> `Buffers`
  - `<leader>fh` -> `Help Tags`

---

# Neovim Picker File-Open Freeze

## Goal

- Remove the long UI freeze that happens after selecting a file from the Neovim picker.

## Acceptance Criteria

- Opening a normal project file via the configured picker no longer blocks Neovim for an extended period.
- The fix keeps existing picker keybindings and file-open behavior intact.
- The changed config still loads cleanly in a headless Neovim check.
- Verification includes a deterministic file-open probe against this repo config.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: config-only performance fix; used deterministic probes instead)
- [x] Run verification (headless/profile/manual-style probes)
- [x] Summarize changes + verification story
- [x] Record lessons (N/A: no new correction/postmortem lesson this turn)
- [x] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Picker is `folke/snacks.nvim`; file-open lag is likely in post-selection buffer setup rather than file search.
- Current file-open path eagerly loads multiple `BufRead` plugins: treesitter, gitsigns, trouble, lspsaga, colorizer, editorconfig, todo-comments, mini, autopairs, and others.
- `gitsigns.nvim` enables `current_line_blame = true`, which is a plausible per-open latency source in larger repos.
- Treesitter highlight currently enables `use_languagetree = true`, which can materially increase open cost for injected-language files.
- The steady-state `:edit` path improved more than the full startup profile, which suggests the user-visible freeze was mostly lazy-loading work on first buffer open rather than raw file I/O.
- Reopened after user correction: the remaining hang is specific to `snacks` picker selection, so the next pass must inspect `snacks` picker open/select behavior directly instead of treating this as a generic file-open slowdown.
- User clarified the hang only happens for TypeScript files in `Desktop/Joby/web`, which shifts the diagnosis from picker internals to project-specific JS/TS LSP startup.
- A representative TSX buffer in `apps/usr` attaches five clients: `typescript-tools`, `eslint`, `tailwindcss`, `cssmodules_ls`, and `graphql`.
- Upstream `tailwindcss` LSP config was scanning the entire Git root recursively for a Tailwind CSS entrypoint before init; in `Desktop/Joby/web` that includes hidden worktrees and `node_modules`.
- The custom `LspProgress` notifier was emitting noisy duplicate messages for `typescript-tools` and `eslint`, which likely amplified the “hang” perception during TS project initialization.

## Verification Plan

- Profile a representative `:edit` path with this repo config and capture the slowest startup/file-open segments.
- After the change, rerun the same probe to confirm improvement and ensure no headless load errors.

## Results

- Changed `nvim/.config/nvim/lua/plugins/editor.lua`:
  - Moved `trouble.nvim` to command-based loading.
  - Moved `mini.nvim`, `vim-wordmotion`, and `todo-comments.nvim` off `BufRead`.
  - Moved `nvim-autopairs` to `InsertEnter`.
- Changed `nvim/.config/nvim/lua/plugins/lsp.lua`:
  - Moved `lspsaga.nvim` to `LspAttach`.
  - Scoped `lsp_extensions.nvim` to Rust buffers.
  - Moved `lspkind-nvim` to `InsertEnter`.
- Changed `nvim/.config/nvim/lua/plugins/syntax.lua`:
  - Scoped `nvim-ts-autotag` to tag-oriented filetypes instead of every `BufRead`.
- Changed `nvim/.config/nvim/lua/lsp/servers/tailwindcss.lua`:
  - Replaced the upstream whole-repo Tailwind CSS entrypoint scan with a local override that searches only likely entry CSS files inside the resolved app root.
  - Excluded heavy directories such as `node_modules`, `.git`, `.worktrees`, `.claude`, `dist`, and `build`.
  - Supports both Tailwind v4 `@import "tailwindcss";` and Tailwind v3 `@tailwind ...` entry styles.
- Changed `nvim/.config/nvim/lua/plugins/lsp.lua`:
  - Disabled `typescript-tools` separate diagnostic server to reduce TS project startup fan-out.
- Changed `nvim/.config/nvim/lua/config/autocmds.lua`:
  - Suppressed `LspProgress` notifications for `typescript-tools` and `eslint`.
  - Deduplicated identical progress title/message text for remaining clients.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/plugins/editor.lua nvim/.config/nvim/lua/plugins/lsp.lua nvim/.config/nvim/lua/plugins/syntax.lua` passed.
- `stylua --check nvim/.config/nvim/lua/lsp/servers/tailwindcss.lua nvim/.config/nvim/lua/plugins/lsp.lua nvim/.config/nvim/lua/config/autocmds.lua` passed.
- `XDG_STATE_HOME=/tmp/codex-nvim-state-joby XDG_CACHE_HOME=/tmp/codex-nvim-cache-joby nvim --headless '+lua require("lsp")' '+qa'` passed.
- Headless startup baseline before change:
  - `nvim --headless --startuptime /tmp/nvim-start-empty.log '+qa'` -> `116.847 ms`
  - `nvim --headless --startuptime /tmp/nvim-start-open.log '+edit /Users/jeremy.monson/dotfiles/AGENTS.md' '+qa'` -> `177.702 ms`
- Warm-cache startup after change:
  - `nvim --headless --startuptime /tmp/nvim-start-empty-after-warm.log '+qa'` -> `135.369 ms`
  - `nvim --headless --startuptime /tmp/nvim-start-open-after-warm.log '+edit /Users/jeremy.monson/dotfiles/AGENTS.md' '+qa'` -> `179.989 ms`
- Direct in-session `:edit` timing before change:
  - `zsh/.zshrc`: `56.03 ms`
  - `AGENTS.md`: `47.34 ms`
  - `lua/plugins/editor.lua`: `28.08 ms`
- Direct in-session `:edit` timing after change (warm cache):
  - `zsh/.zshrc`: `22.00 ms`
  - `AGENTS.md`: `12.42 ms`
  - `lua/plugins/editor.lua`: `29.88 ms`
- Constraint note:
  - Interactive picker UI was not reproduced directly in this environment; verification targeted the post-selection `:edit` path that the picker ultimately triggers.
- Joby-specific probe before TS-focused fixes:
  - `nvim --headless ... measure('/Users/jeremy.monson/Desktop/Joby/web/apps/usr/app/entry.client.tsx')` -> `193.05 ms`
  - Same command for `/Users/jeremy.monson/Desktop/Joby/web/apps/usr/app/styles/app.css` -> `22.64 ms`
- Joby-specific probe after TS-focused fixes:
  - TSX open remained in the same range (`214-218 ms`) in headless `:edit` timing, so the remaining issue is likely asynchronous LSP initialization/redraw rather than raw synchronous file open.
  - A one-second post-open probe showed no more emitted TS/ESLint progress messages, while Tailwind now resolves `configFile=/Users/jeremy.monson/Desktop/Joby/web/apps/usr/app/styles/app.css`.
  - The same TSX buffer still attaches five clients:
    - `cssmodules_ls`
    - `eslint`
    - `graphql`
    - `tailwindcss`
    - `typescript-tools`

---

# Elixir LSP Migration to Expert

## Goal

- Move Neovim Elixir LSP from current setup (`elixir-tools`/`elixirls`) to `expert-lsp` per official installation docs.

## Acceptance Criteria

- Neovim uses `expert` LSP for Elixir-family filetypes.
- `elixir-tools.nvim` Elixir LSP wiring is removed to avoid conflicting LSP clients.
- Mason ensure list installs `expert` instead of `elixirls`.
- Existing global LSP attach behavior/keymaps remain intact.
- Lua config loads without syntax/runtime errors in a headless check.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [ ] Add/adjust tests (N/A: config-only change, no existing Neovim config test harness)
- [x] Run verification (lint/tests/build/manual repro)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Official `expert-lsp` docs state `elixir-tools.nvim` does not support Expert yet; use `nvim-lspconfig` directly.
- Upstream `nvim-lspconfig` has built-in `expert` config (`cmd = { "expert", "--stdio" }`).
- Repository currently has both legacy `lsp/*` setup and `elixir-tools.nvim` plugin config.

## Verification Plan

- Run a headless Neovim startup check with this config.
- Inspect config references to ensure no remaining active `elixirls` setup for Elixir.

## Results

- Changed `nvim/.config/nvim/lua/plugins/lsp.lua`:
  - Removed `elixir-tools/elixir-tools.nvim` block to avoid conflicting Elixir LSP clients.
- Changed `nvim/.config/nvim/lua/lsp/init.lua`:
  - Switched Mason ensure list from `elixirls` to `expert`.
  - Added Mason auto-enable exclusions for `elixirls`, `nextls`, and `lexical`.
- Changed `nvim/.config/nvim/lua/lsp/servers/init.lua`:
  - Replaced commented `elixirls` entry with `expert`.
- Added `nvim/.config/nvim/lua/lsp/servers/expert.lua`:
  - Registered `vim.lsp.config('expert', { on_attach = on_attach })` to keep existing LSP keymaps/attach behavior.

### Verification Evidence

- `XDG_CACHE_HOME=/tmp/nvim-cache XDG_STATE_HOME=/tmp/nvim-state NVIM_APPNAME=nvim nvim --headless '+lua require("lsp")' '+qa'` passed.
- `stylua --check nvim/.config/nvim/lua/lsp/init.lua nvim/.config/nvim/lua/lsp/servers/init.lua nvim/.config/nvim/lua/lsp/servers/expert.lua` passed.
- `stylua --check nvim/.config/nvim/lua/plugins/lsp.lua` reports pre-existing formatting drift in unrelated lines.

---

# Zsh Sourcing Fix

## Goal

- Restore reliable shell startup by ensuring `.zshenv` and `.zshrc` source optional tooling/config safely and in the intended order.

## Acceptance Criteria

- Interactive startup with repo dotfiles (`ZDOTDIR=.../zsh zsh -lic`) completes without "command not found" or "no such file" errors from startup config.
- Non-interactive startup (`ZDOTDIR=.../zsh zsh -lc`) remains clean and fast.
- `.zshenv` contains environment-only behavior safe for all zsh invocations.
- `.zshrc` loads plugin manager first, then prompt init, then local function file (when present).

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: shell dotfile config; used deterministic startup probes instead)
- [x] Run verification (startup probes + syntax check)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Current startup contains unconditional `kitty` completion and unconditional `source ~/.functions`, both unsafe when absent.
- Antidote initialization should fail gracefully when clone/load is unavailable.
- `.zshenv` should avoid TTY-dependent side effects in non-interactive shells.

## Results

- Changed `zsh/.zshenv`:
  - Guarded `GPG_TTY` assignment with `[[ -t 0 ]]` to avoid non-interactive side effects.
  - Replaced hardcoded `/Users/jeremy.monson/...` paths with `$HOME`-based paths.
  - Guarded optional env sources: `~/.cargo/env` and `~/.rover/env`.
- Changed `zsh/.zshrc`:
  - Guarded `mise` init behind command availability.
  - Added resilient antidote bootstrap/load flow that no-ops cleanly if clone/source is unavailable.
  - Preserved intended load order: antidote/plugin load before starship init.
  - Guarded `source ~/.functions` behind file existence.
  - Guarded kitty completion behind `command -v kitty`.

### Verification Evidence

- `zsh -n zsh/.zshenv` passed.
- `zsh -n zsh/.zshrc` passed.
- `ZDOTDIR=/Users/jeremy.monson/dotfiles/zsh zsh -lc 'echo NON_INTERACTIVE_OK'` passed (`NON_INTERACTIVE_OK`).
- `ZDOTDIR=/Users/jeremy.monson/dotfiles/zsh zsh -lic 'echo INTERACTIVE_OK'` passed (`INTERACTIVE_OK`).
- Scan for hard startup failures in interactive probe output returned none:
  - searched for `command not found|no such file|source:` and found no matches.

### Constraint Notes

- In this sandbox only, starship still logs a cache permission warning for `/Users/jeremy.monson/.cache/...`; this is environment permission-related and outside the repo workspace.

---

# Stow Script Portability Fix

## Goal

- Ensure dotfiles bootstrap scripts work when invoked exactly as the user ran them (`sh stow.sh`, `sh cleanenv.sh`) and successfully create `~/.zshenv`/`~/.zshrc` symlinks.

## Acceptance Criteria

- `sh stow.sh` no longer fails with `pushd/popd` errors.
- `sh cleanenv.sh` no longer fails with `pushd/popd` errors.
- Scripts work even when `DOTFILES` and `STOW_FOLDERS` are not pre-exported.
- In a clean HOME, `sh stow.sh` creates symlinks for `~/.zshenv` and `~/.zshrc`.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: shell scripts; used deterministic command probes)
- [x] Run verification (script execution + symlink checks)
- [x] Summarize changes + verification story
- [x] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Existing scripts assume zsh-only builtins (`pushd/popd`) and externally set env vars.
- `cleanenv.sh` loops with variable `i` but references `folder`, so unstow target is wrong.

## Results

- Changed `stow.sh`:
  - Converted to POSIX-compatible `sh`.
  - Removed `pushd/popd`; now uses script-directory resolution + `cd`.
  - Added defaults when env vars are unset:
    - `DOTFILES` defaults to script directory.
    - `STOW_FOLDERS` defaults to `dotfiles,nvim,kitty,tmux,starship,zsh`.
  - Added `stow` availability check and idempotent unstow-before-stow behavior.
- Changed `cleanenv.sh`:
  - Converted to POSIX-compatible `sh`.
  - Removed `pushd/popd`; now uses script-directory resolution + `cd`.
  - Added the same env defaults and `stow` check.
  - Fixed loop variable bug (`folder` now used consistently).
  - Made cleanup idempotent when folders are already unstowed.

### Verification Evidence

- `sh -n stow.sh` passed.
- `sh -n cleanenv.sh` passed.
- Isolated end-to-end test with `DOTFILES` and `STOW_FOLDERS` unset:
  - `sh ./stow.sh` created links:
    - `.zshenv -> dotfiles/zsh/.zshenv`
    - `.zshrc -> dotfiles/zsh/.zshrc`
  - `sh ./cleanenv.sh` removed stowed links.
  - Cleanup probe returned `cleanup_ok`.
- Real repo run:
  - `sh ./stow.sh` succeeded.
  - Verified links in home:
    - `/Users/jeremy.monson/.zshenv -> dotfiles/zsh/.zshenv`
    - `/Users/jeremy.monson/.zshrc -> dotfiles/zsh/.zshrc`

---

# Pushd Preference Alignment

## Goal

- Preserve `pushd/popd` in bootstrap scripts while keeping compatibility with `sh stow.sh` invocation.

## Acceptance Criteria

- Scripts use `pushd/popd` again.
- Running `sh stow.sh` still works by handing off to `zsh`.
- Existing safety defaults (`DOTFILES`/`STOW_FOLDERS`) remain in place.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: shell scripts; used deterministic command probes)
- [x] Run verification (script invocation probes)
- [x] Summarize changes + verification story
- [x] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Results

- Changed `stow.sh`:
  - Restored `pushd/popd`.
  - Added auto-handoff to zsh when invoked as `sh stow.sh`: `exec zsh "$0" "$@"`.
  - Kept env fallbacks for `DOTFILES` and `STOW_FOLDERS`.
  - Kept idempotent unstow-then-stow behavior.
- Changed `cleanenv.sh` similarly:
  - Restored `pushd/popd`.
  - Added zsh auto-handoff for `sh cleanenv.sh`.
  - Kept env fallbacks and idempotent unstow behavior.
- Added `setopt sh_word_split` so comma-delimited folder expansion works correctly under zsh.

### Verification Evidence

- `zsh -n stow.sh` passed.
- `zsh -n cleanenv.sh` passed.
- Real repo invocation style:
  - `sh ./stow.sh` passed.
  - `./stow.sh` passed.
- Isolated end-to-end with temporary HOME:
  - `HOME=/tmp/... sh ./stow.sh` created:
    - `.zshenv -> dotfiles/zsh/.zshenv`
    - `.zshrc -> dotfiles/zsh/.zshrc`
  - `HOME=/tmp/... sh ./cleanenv.sh` removed stowed files.
  - Probe returned `tmp_cleanup_ok`.

---

# Dotfiles Audit

## Goal

- Audit current dotfiles for correctness, bootstrap reliability, and maintainability risks; provide prioritized improvements with file-level references.

## Acceptance Criteria

- Findings are prioritized by severity and reference exact files/lines.
- Audit includes shell bootstrap, zsh startup, and Neovim config surfaces.
- Verification evidence includes concrete commands used during review.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice (N/A: audit only, no code changes required)
- [x] Add/adjust tests (N/A: review task; used static checks/probes)
- [x] Run verification (lint/check/probe commands)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Verification Evidence

- `shellcheck --version` (available).
- `shellcheck install.sh stow.sh cleanenv.sh`.
- `rg -n` path/hardcode scans over shell + nvim files.
- `nvim --headless` startup probes with default and temporary XDG directories.
- `python --version` / `python3 --version` checks for alias compatibility.

---

# Claude Bash Hang Investigation

## Goal

- Identify and remove shell startup behaviors that can cause Claude Code command execution to stall when running bash-oriented commands.

## Acceptance Criteria

- Non-TTY command-runner startup path (`zsh -ic`) avoids heavy interactive tooling and network operations.
- Startup no longer emits zle/starship initialization errors in non-TTY probes.
- `bash -lc` path remains fast after changes.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: shell config; used deterministic startup probes)
- [x] Run verification (timed zsh/bash probes)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- `.zshrc` currently initializes `mise`/`starship`/plugin manager even in non-TTY command contexts.
- `.zshrc` attempts to `git clone` antidote when missing; this can block startup under constrained network.

## Results

- Changed `zsh/.zshrc`:
  - Added a non-TTY early return guard to skip prompt/plugin bootstrap for command-runner sessions.
  - Removed automatic `git clone` during shell startup; now only loads antidote if already present.
  - Added a tty-only warning when antidote is missing, instead of silent network attempts.

### Verification Evidence

- `zsh -n zsh/.zshrc` passed.
- `zsh -ic 'echo ZSH_NONTTY_OK'` now returns immediately with no zle/starship init errors in output.
- Timed probe:
  - `zsh -ic 'echo ...'` -> `real 0.01`
  - `bash -lc 'echo ...'` -> `real 0.01`
  - `zsh -ic 'bash -lc \"echo ...\"'` -> `real 0.04`

---

# Joby MKT Typecheck Hang Triage

## Goal

- Reproduce and identify why `bun run typecheck` appears to hang in `~/Desktop/Joby/web/apps/ops/mkt`.

## Acceptance Criteria

- Confirm behavior under `bash -lc` and direct invocation in the mkt app.
- Determine whether delay is shell startup vs TypeScript workload.
- Provide concrete command evidence with timing and diagnostics.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice (N/A: investigation only)
- [x] Add/adjust tests (N/A: used runtime probes)
- [x] Run verification (timing + TypeScript diagnostics)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Results

- In `~/Desktop/Joby/web` root, `bun run typecheck` fails immediately: script does not exist there.
- In `~/Desktop/Joby/web/apps/ops/mkt`, both invocations:
  - `bash -lc 'bun run typecheck'`
  - `bun run typecheck`
  reached `$ tsc`, then completed in ~12s with TypeScript errors (not an infinite hang).
- `bunx tsc --diagnostics --pretty false` in mkt reported:
  - Files: `5605`
  - Memory used: `~1.9GB`
  - Check time: `8.60s`
  - Total time: `11.24s`
- Claude-specific behavior is reproducible in logs:
  - Session `1e7c40df-efbe-43fd-a857-efd7d95b92ae` shows repeated `bash_progress` with `totalLines: 0` for `bun run typecheck` while elapsed seconds increase.
  - Those runs were then manually backgrounded (`b53693b`, `b3c66c7`) and subsequently marked `status>killed`.
  - Debug log records `LocalBashTask b53693b kill requested` and `LocalBashTask b3c66c7 kill requested`.
- A heartbeat wrapper command (`while sleep 5; do echo ...; done`) produced periodic output and completed with exit code `0`.

### Verification Evidence

- `cd ~/Desktop/Joby/web/apps/ops/mkt && /usr/bin/time -p bash -lc 'bun run typecheck'`
- `cd ~/Desktop/Joby/web/apps/ops/mkt && /usr/bin/time -p bun run typecheck`
- `cd ~/Desktop/Joby/web/apps/ops/mkt && /usr/bin/time -p bunx tsc --diagnostics --pretty false`
- `rg` over `~/.claude/projects/-Users-jeremy-monson-Desktop-Joby-web/1e7c40df-efbe-43fd-a857-efd7d95b92ae.jsonl` for `bash_progress`, `backgrounded by user`, and `status>killed`.
- `rg` over `~/.claude/debug/1e7c40df-efbe-43fd-a857-efd7d95b92ae.txt` for `LocalBashTask .* kill requested`.
- `bash -lc 'cd /Users/jeremy.monson/Desktop/Joby/web/apps/ops/mkt && (while sleep 5; do echo \"[typecheck] still running...\"; done & hb=$!; bun run typecheck; ec=$?; kill $hb 2>/dev/null; wait $hb 2>/dev/null; exit $ec)'`.

---

# Claude Runner Dotfiles Hardening

## Goal

- Reduce the chance that shell dotfiles interfere with command-runner shells used by coding agents.

## Acceptance Criteria

- `zsh -ic '...'` command strings do not initialize prompt/plugin stack.
- PATH remains de-duplicated after repeated `.zshenv` sourcing.
- `bun run typecheck` in mkt still succeeds under `zsh -ic` and `bash -lc`.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: shell config; used deterministic probes)
- [x] Run verification (startup probes + typecheck timings)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Results

- Changed `zsh/.zshrc`:
  - Added a guard to skip prompt/plugin bootstrap when `ZSH_EXECUTION_STRING` is set (`zsh -c` / `zsh -ic` command-runner shells).
- Changed `zsh/.zshenv`:
  - Added PATH normalization/dedup after optional env scripts.
  - Removed stale inherited typo path (`/Users/jmonson/Library/pnpm`) when present.

### Verification Evidence

- `zsh -n zsh/.zshenv` passed.
- `zsh -n zsh/.zshrc` passed.
- `zsh -ic 'echo ZSH_IC_OK'` produced clean output (`ZSH_IC_OK`) without prompt/plugin side effects.
- `zsh -lc 'source ~/.zshenv; source ~/.zshenv; source ~/.zshenv; print -r -- "$PATH" | tr ":" "\\n" | sort | uniq -d'` returned no duplicates.
- `/usr/bin/time -p zsh -ic 'cd /Users/jeremy.monson/Desktop/Joby/web/apps/ops/mkt && bun run typecheck'` completed (`real ~13.27`).
- `/usr/bin/time -p bash -lc 'cd /Users/jeremy.monson/Desktop/Joby/web/apps/ops/mkt && bun run typecheck'` completed (`real ~13.57`).

---

# Dotfiles Quick Wins

## Goal

- Apply a small, high-ROI cleanup pass for bootstrap reliability, shell maintainability, and config drift.

## Acceptance Criteria

- `install.sh` is location-independent and does not silently ignore critical failures.
- README install/docs instructions match repository reality.
- `.zshrc` no longer has duplicate aliases and avoids hardcoded Bun version paths.
- `tmux` config duplicate mouse bindings are removed.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: config/scripts; use deterministic shell probes)
- [x] Run verification (syntax/startup/manual command checks)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Results

- Changed `install.sh`:
  - Switched to `#!/usr/bin/env bash` with `set -euo pipefail`.
  - Added `script_dir` resolution to remove hard dependency on `$HOME/dotfiles`.
  - Removed silent ignore behavior for `brew bundle` and `mise trust`.
  - Replaced `which zsh` with `command -v zsh`.
- Changed `README.md`:
  - Updated install command to `./install.sh`.
  - Replaced broken `docs/COMMANDS.md` reference with real source files (`zsh/.zshrc`, `zsh/.functions`).
- Changed `zsh/.zshrc`:
  - Removed duplicate alias definitions for `g` and `path`.
  - Replaced hardcoded Bun completion path (`Cellar/bun/1.0.1/...`) with non-versioned lookup in common Homebrew site-function paths.
- Changed `tmux/.tmux.conf`:
  - Removed duplicate `WheelUpPane`/`WheelDownPane` bindings at the end of the file.

### Verification Evidence

- `bash -n install.sh` passed.
- `zsh -n zsh/.zshrc` and `zsh -n zsh/.zshenv` passed.
- `tmux -L dotfiles-audit -f /Users/jeremy.monson/dotfiles/tmux/.tmux.conf start-server \; show -g prefix \; kill-server` succeeded (`prefix C-a`).
- `rg -n "docs/COMMANDS\\.md|sh install\\.sh|\\.\\/install\\.sh" README.md` shows only `./install.sh`.
- `rg -n "^alias g=|^alias path=|/opt/homebrew/Cellar/bun/1\\.0\\.1|bun_completion_file" zsh/.zshrc` confirms single `g` alias, single `path` alias, and no pinned Bun version path.
- `rg -n "WheelUpPane|WheelDownPane" tmux/.tmux.conf` confirms one binding pair remains.

---

# Dotfiles Second Pass

## Goal

- Improve reproducibility by pinning `mise` tool versions and harden `zsh/.functions` for zsh-sourced safety.

## Acceptance Criteria

- `mise.toml` uses explicit versions matching current installed toolchain.
- `zsh/.functions` avoids brittle positional checks and shell-fragile conditionals.
- `zsh/.functions` still parses cleanly in zsh.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: config/scripts; use syntax and load probes)
- [x] Run verification (mise + zsh probes)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Results

- Changed `mise.toml`:
  - Replaced floating versions (`latest` / `lts`) with explicit pinned versions matching current installed toolchain:
    - `node = "24.12.0"`
    - `python = "3.14.2"`
    - `ruby = "3.4.7"`
    - `go = "1.25.5"`
    - `elixir = "1.19.4-otp-28"`
    - `erlang = "28.3"`
- Changed `zsh/.functions`:
  - Switched shebang to zsh for consistency with actual usage (`source` from `.zshrc`).
  - Replaced `hash git` + `$?` pattern with direct `command -v git` guard.
  - Replaced Darwin detection test with zsh-safe `[[ "$(uname -s)" != "Darwin" ]]`.
  - Hardened `ftm`/`ftmk` argument checks from `[ $1 ]` to `[[ -n "${1:-}" ]]` to avoid unbound/empty positional issues.

### Verification Evidence

- `zsh -n zsh/.functions` passed.
- `zsh -lc 'source /Users/jeremy.monson/dotfiles/zsh/.functions; echo FUNCTIONS_SOURCE_OK'` passed.
- `mise current` in repo reflected the pinned versions.
- `mise trust /Users/jeremy.monson/dotfiles/mise.toml` passed.

---

# Dotfiles Improvement Sweep

## Goal

- Complete the remaining high-impact dotfiles improvements (shell/plugin path portability, compinit caching, tmux terminal defaults, non-mutating checks, git identity isolation, and CI sanity checks).

## Acceptance Criteria

- Antidote bootstrap path is consistent and not split across competing install methods.
- `.zsh_plugins.txt` has no hardcoded repo path and completion init is cached.
- Interactive-only behaviors in `zsh/.functions` are guarded.
- `tmux` default terminal is explicit and stable.
- `make check` does not mutate files.
- `dotfiles/.gitconfig` uses local include for personal identity.
- CI workflow exists for syntax/lint/format checks.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: config/scripts; use deterministic probes)
- [x] Run verification (local checks + workflow syntax sanity)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Results

- Unified antidote loading around Homebrew install path:
  - `zsh/.zshrc` now looks for `antidote.zsh` in `/opt/homebrew/opt/antidote/...` and `/usr/local/opt/antidote/...`.
  - Removed dependency on `~/.antidote` clone path.
- Removed hardcoded dotfiles repo path from plugin list:
  - `zsh/.zsh_plugins.txt` now references `~/run_compinit.zsh`.
- Added cached completion initialization:
  - `zsh/run_compinit.zsh` now uses `.zcompdump` with `compinit -C` fast path when dump is newer than 24h.
- Guarded interactive-only `cd` behavior:
  - `zsh/.functions` now runs `ls` after `cd` only when shell is interactive.
- Improved tmux terminal stability:
  - `tmux/.tmux.conf` now sets `default-terminal` to `tmux-256color` and enables RGB features for common terminals.
- Made checks non-mutating:
  - `Makefile` adds `format-check` and `check` now depends on `format-check lint`.
- Isolated personal git identity:
  - `dotfiles/.gitconfig` now includes `~/.gitconfig.local`.
  - Removed global `commit.gpgsign` from shared config so signing preference can live in local override.
  - Added template file `dotfiles/.gitconfig.local.example`.
  - Added README notes for local git identity setup.
- Added CI workflow:
  - `.github/workflows/dotfiles-ci.yml` runs bash/zsh syntax checks, `shfmt -d`, `shellcheck`, `luacheck`, and `stylua --check`.
- CI hardening fixes applied:
  - `install.sh` and `bin/tmux-sessionizer` updated to satisfy `shellcheck` and `shfmt`.

### Verification Evidence

- `bash -n install.sh bin/tmux-sessionizer` passed.
- `shellcheck install.sh bin/tmux-sessionizer` passed.
- `shfmt -d install.sh bin/tmux-sessionizer` passed (clean).
- `zsh -n zsh/.zshenv zsh/.zshrc zsh/.functions zsh/run_compinit.zsh stow.sh cleanenv.sh` passed.
- `tmux -L dotfiles-audit -f /Users/jeremy.monson/dotfiles/tmux/.tmux.conf start-server \; show -g default-terminal \; show -g prefix \; kill-server` returned:
  - `default-terminal tmux-256color`
  - `prefix C-a`
- `zsh -c 'source /Users/jeremy.monson/dotfiles/zsh/run_compinit.zsh; source /Users/jeremy.monson/dotfiles/zsh/run_compinit.zsh; ...'` created `.zcompdump` and completed successfully.
- `make -n check` now prints:
  - `stylua --check ...`
  - `luacheck .`
- `ruby -e 'require "yaml"; YAML.load_file(".github/workflows/dotfiles-ci.yml")'` passed.

---

# Dotfiles Operational Hardening (No Test Additions)

## Goal

- Add practical operational safeguards to dotfiles bootstrap/shell setup without introducing or expanding test infrastructure.

## Acceptance Criteria

- A `doctor` command exists to quickly diagnose common shell/dotfiles issues.
- `zsh` supports optional machine-local overrides via `~/.zshenv.local` and `~/.zshrc.local`.
- `install.sh` supports a non-mutating check mode and a non-interactive mode for automation.
- Documentation clearly describes upgrade behavior and new operational commands.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A per user direction; using deterministic shell probes instead)
- [x] Run verification (syntax/manual probes)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Keep behavior backwards-compatible: `./install.sh` should still perform full install by default.
- Avoid side effects in check/diagnostic commands.
- Prefer explicit, actionable diagnostics over automatic mutation in doctor tooling.

## Results

- Added `bin/dotfiles-doctor`:
  - Validates required commands, `~/.zshenv`/`~/.zshrc` presence and symlinks, zsh parse checks, antidote path, tmux terminfo, and local override files.
- Updated `Makefile`:
  - Added `doctor` target (`make doctor`) to run health diagnostics.
- Updated `zsh/.zshenv`:
  - Sources `~/.zshenv.local` when present.
- Updated `zsh/.zshrc`:
  - Sources `~/.zshrc.local` when present.
- Updated `install.sh`:
  - Added `--check` mode for non-mutating diagnostics.
  - Added `--yes` mode for non-interactive installs where possible.
  - Added terminfo diagnostics and skipped `chsh` automatically in `--yes`.
  - Kept default no-flag behavior as full install.
- Updated docs:
  - `README.md` now documents `--check`, `--yes`, `make doctor`, local overrides, and upgrade notes.
  - Added `UPGRADE.md` with dated migration notes for these changes.

### Verification Evidence

- `bash -n install.sh bin/dotfiles-doctor` passed.
- `zsh -n zsh/.zshenv zsh/.zshrc stow.sh cleanenv.sh` passed.
- `shellcheck install.sh bin/dotfiles-doctor` passed.
- `./install.sh --help` prints usage with `--check` and `--yes`.
- `./bin/dotfiles-doctor` passed with 0 failures (2 optional local-override warnings).
- `make doctor` passed with same doctor summary.
- `./install.sh --check` passed and ran doctor + terminfo diagnostics.

---

# Full Dotfiles Audit (Shell + Neovim)

## Goal

- Perform a full audit of this dotfiles repo, including Neovim configuration, and identify concrete gaps/opportunities for improvement.

## Acceptance Criteria

- Findings are prioritized by severity/impact with concrete file references.
- Audit covers shell bootstrap, tooling/install path, tmux, and Neovim architecture/plugin/LSP surfaces.
- Recommendations are actionable and scoped (quick wins vs larger upgrades).
- Verification evidence lists the static checks/commands used for conclusions.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice (N/A: audit-only)
- [x] Add/adjust tests (N/A: audit-only task)
- [x] Run verification (lint/syntax/probes)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- This is an audit-only pass; no behavior-changing code edits required unless separately requested.
- Prioritize gaps that affect reliability, maintainability, and tool-runner compatibility.

## Results

- Completed a full static audit of shell bootstrap/tooling (`zsh`, install, stow, CI, Makefile) and Neovim config architecture (plugin loading, mappings, LSP stack).
- Identified concrete high-impact gaps:
  - Broken/legacy Neovim keymaps/commands (missing plugins or commands).
  - LSP bootstrap guard logic bug and legacy diagnostic/formatting API usage.
  - Mixed plugin architecture with duplicate/unused specs and stale config files.
  - Local quality gate drift (`luacheck` broken locally, stylua drift blocking `make check`).
  - Shell drift issues (stale PATH entries, aliases pointing to missing commands).

### Verification Evidence

- Shell/tooling checks:
  - `zsh -n zsh/.zshenv zsh/.zshrc zsh/.functions zsh/run_compinit.zsh stow.sh cleanenv.sh` passed.
  - `bash -n install.sh bin/dotfiles-doctor bin/tmux-sessionizer globals.sh` passed.
  - `shellcheck install.sh bin/dotfiles-doctor bin/tmux-sessionizer globals.sh` failed on `globals.sh` (`SC2148`: missing shebang/shell directive).
  - `make -n check` shows `stylua --check` + `luacheck .`.
  - `make check` fails at `stylua --check` due formatting drift in multiple Neovim files.
  - `luacheck --version` fails with missing Lua module (`luacheck.main`), indicating local toolchain drift.
- Neovim checks/probes:
  - `XDG_CONFIG_HOME=... XDG_CACHE_HOME=/tmp/... XDG_STATE_HOME=/tmp/... nvim --headless '+lua print("NVIM_BOOT_OK")' '+qa'` passed.
  - `... nvim --headless '+lua require("lsp")' '+qa'` passed.
  - `... nvim --headless '+Neogen' '+qa'` errors with `module 'neogen' not found`.
  - `... nvim --headless '+ToggleTerm' '+qa'` errors `E492: Not an editor command: ToggleTerm`.
  - `... nvim --headless '+CopyMatches' '+qa'` errors `E492: Not an editor command: CopyMatches`.
- Structural scans:
  - Duplicate plugin spec declarations found across `lazy_init.lua` and `plugins/*.lua` (e.g., `stabilize.nvim`, `editorconfig.nvim`).
  - Orphan plugin config files found with zero references (`catppuccin-config.lua`, `compe.lua`, `notify.lua`, `onedark.lua`).
  - LSP server files present but not wired (`cssmodules_ls.lua`, `elixir.lua` not required from `lsp/servers/init.lua`).

---

# Dotfiles Remediation Pass

## Goal

- Implement the prioritized audit fixes across shell/tooling and Neovim so the configuration is reliable, internally consistent, and verifiable.

## Acceptance Criteria

- No broken Neovim keymaps/commands remain in default startup state.
- LSP bootstrap and diagnostics/formatting wiring use safe current API patterns.
- Plugin loading architecture has no duplicate declarations for the same plugin.
- Shell config avoids stale hardcoded command assumptions where practical.
- CI/static checks cover all primary shell entrypoints used in this repo.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: config repo; using deterministic syntax/runtime probes)
- [x] Run verification (lint/syntax/headless probes)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Keep blast radius focused on audited findings; avoid broad stylistic rewrites.
- Preserve existing user preferences (e.g., pushd/popd workflow) while improving safety.
- Use temporary XDG paths for headless Neovim probes to avoid host permission side effects.

## Results

- Neovim functional breakages fixed:
  - Removed stale command/mapping references to unavailable `Neogen`, `ToggleTerm`, and `CopyMatches`.
  - Rewired `<leader>tt` to `snacks.terminal()` and removed duplicate stale mappings.
  - Fixed `snacks.nvim` key callbacks to require module safely at runtime.
- LSP reliability hardening:
  - Fixed bootstrap guard logic in `lsp/init.lua` (all core deps must be present).
  - Migrated diagnostics setup to `vim.diagnostic.config`.
  - Updated formatting capability fields from `document_formatting` to `documentFormattingProvider`.
  - Updated typescript-tools diagnostic forwarding to use default publish diagnostics handler.
  - Wired `cssmodules_ls` server and removed stale unused `elixir.lua` server module.
- Plugin architecture consolidation:
  - Startup now uses `require('config.lazy')` from `lua/init.lua`.
  - Added `plugins/legacy.lua` for legacy plugin specs and removed `lazy_init.lua`/`lazynvim.lua`.
  - Removed dead plugin config modules: `catppuccin-config.lua`, `compe.lua`, `notify.lua`, `onedark.lua`.
- Shell/tooling hardening:
  - `.zshenv` now adds PATH entries only when directories exist (avoids stale entries).
  - `.zshrc` now guards `vtop` alias and updates `urlencode` alias to Python 3.
  - `globals.sh` is now a proper executable shell script with strict mode.
  - `dotfiles-doctor` now checks `nvim`, `stylua`, and broken/missing `luacheck`.
  - Added `brew 'luacheck'` to `Brewfile`.
  - `Makefile` lint now fails with explicit remediation guidance when `luacheck` is broken.
- CI coverage expanded:
  - Added syntax/format/shellcheck coverage for `globals.sh` and `bin/dotfiles-doctor`.
  - Added headless Neovim LSP boot step with temporary XDG paths.

### Verification Evidence

- `bash -n install.sh globals.sh bin/dotfiles-doctor bin/tmux-sessionizer` passed.
- `zsh -n zsh/.zshenv zsh/.zshrc zsh/.functions zsh/run_compinit.zsh stow.sh cleanenv.sh` passed.
- `shellcheck install.sh globals.sh bin/dotfiles-doctor bin/tmux-sessionizer` passed.
- `shfmt -d install.sh globals.sh bin/dotfiles-doctor bin/tmux-sessionizer` passed.
- `stylua --check -g '*.lua' -- ./nvim/.config/nvim` passed.
- `XDG_CONFIG_HOME=... XDG_CACHE_HOME=/tmp/... XDG_STATE_HOME=/tmp/... nvim --headless '+lua require("lsp")' '+qa'` passed.
- `rg -n "Neogen|neogen|ToggleTerm|CopyMatches|lazy_init|lazynvim" nvim/.config/nvim` returned no matches.
- `./bin/dotfiles-doctor` and `make doctor` passed (warnings only for optional local overrides + broken local luacheck).
- `./install.sh --check` passed.
- `ruby -e 'require "yaml"; YAML.load_file(".github/workflows/dotfiles-ci.yml")'` passed.
- `make check` now fails with explicit message due local luacheck environment state:
  - `luacheck is missing or broken. Run 'brew install luacheck' (or reinstall via luarocks).`

---

# Neovim Command Docs + Which-Key UX

## Goal

- Document Neovim commands/keymaps and ensure discoverable descriptions, integrated with `which-key`.

## Acceptance Criteria

- Custom Neovim user commands include explicit descriptions.
- Custom keymaps have descriptions where practical for `which-key`/`:map` discoverability.
- `which-key` shows meaningful grouped prefixes for the active custom map layout.
- A committed Neovim command reference document exists in the repo.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: config repo; using deterministic probes)
- [x] Run verification (stylua + headless Neovim)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Prioritize descriptive metadata without changing user muscle memory key choices.
- Keep docs aligned to actual mapped commands in `lua/config/mappings.lua` and plugin key specs.

## Results

- Enhanced keymap helper API:
  - `lua/helpers.lua` now supports `desc` metadata cleanly via both `map` and `buf_map`.
- Added descriptions across custom mapping surfaces:
  - `lua/config/mappings.lua` now sets a description for every custom global mapping.
  - `lua/lsp/on_attach.lua` now sets descriptions for all LSP buffer-local mappings.
  - `lua/plugins/99.lua` corrected prompt mapping descriptions for clarity.
  - `lua/plugins/editor.lua` now includes description metadata for `vim-repeat` key registration.
- Added explicit descriptions to user commands:
  - `lua/config/functions.lua` defines `:LazySync` with `nvim_create_user_command(..., { desc = ... })`.
  - `lua/config/options.lua` adds `desc` to `:Browse`.
- Integrated command discovery with which-key groups:
  - `lua/plugins/ui.lua` now configures grouped leader prefixes via `which-key.add(...)`.
- Added documentation artifact:
  - `nvim/.config/nvim/COMMANDS.md` now documents user commands, custom keymaps, LSP keymaps, plugin keymaps, and configured which-key groups.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/config/mappings.lua nvim/.config/nvim/lua/lsp/on_attach.lua nvim/.config/nvim/lua/config/functions.lua nvim/.config/nvim/lua/config/options.lua nvim/.config/nvim/lua/plugins/ui.lua nvim/.config/nvim/lua/plugins/editor.lua nvim/.config/nvim/lua/plugins/99.lua` passed.
- `XDG_CONFIG_HOME=/Users/jeremy.monson/dotfiles/nvim/.config XDG_CACHE_HOME=/tmp/nvim-cache-docs XDG_STATE_HOME=/tmp/nvim-state-docs nvim --headless '+lua print("NVIM_OK")' '+qa'` passed.
- `XDG_CONFIG_HOME=/Users/jeremy.monson/dotfiles/nvim/.config XDG_CACHE_HOME=/tmp/nvim-cache-docs XDG_STATE_HOME=/tmp/nvim-state-docs nvim --headless '+lua require("lsp")' '+qa'` passed.
- `XDG_CONFIG_HOME=/Users/jeremy.monson/dotfiles/nvim/.config XDG_CACHE_HOME=/tmp/nvim-cache-docs XDG_STATE_HOME=/tmp/nvim-state-docs nvim --headless '+lua local wk=require("which-key"); print("WK_OK")' '+qa'` passed.
- `XDG_CONFIG_HOME=/Users/jeremy.monson/dotfiles/nvim/.config XDG_CACHE_HOME=/tmp/nvim-cache-docs XDG_STATE_HOME=/tmp/nvim-state-docs nvim --headless '+lua local modes={"n","v","x","o","t"}; local missing={}; for _,mode in ipairs(modes) do for _,m in ipairs(vim.api.nvim_get_keymap(mode)) do if m.lhs:find("^<leader>") and (not m.desc or m.desc=="") then table.insert(missing, mode .. " " .. m.lhs) end end end; table.sort(missing); print(vim.inspect(missing))' '+qa'` returned `{}`.

---

# Neovim Cleanup + Lua Window Ops

## Goal

- Simplify and de-muddle Neovim config structure while preserving behavior, and replace legacy Vimscript window-management helpers with Lua.

## Acceptance Criteria

- Legacy window-management logic (`WinMove`) is implemented in Lua and used by keymaps.
- Legacy visual macro helper is implemented in Lua and used by keymaps.
- Highest-confusion keymap ownership conflicts are removed so one key has one clear owner.
- Autocmd/group setup in edited files is idempotent and Lua-native where practical.
- Updated config passes formatting and headless startup checks.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: config repo; using deterministic probes)
- [x] Run verification (stylua + headless Neovim)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Scope cleanup to high-signal reductions in confusion (legacy Vimscript helpers + keymap collisions) and avoid broad stylistic churn.
- Preserve muscle-memory mappings where possible while removing hidden key overrides.

## Results

- Migrated legacy Vimscript helpers to Lua:
  - Added `lua/config/actions.lua` with:
    - `execute_macro_over_visual_range()`
    - `move_window(direction)`
  - Removed legacy `function! ExecuteMacroOverVisualRange`, `function! WinMove`, and unused `function! RangeSearch` blocks from `lua/config/functions.lua`.
- Rewired mappings to Lua callbacks:
  - `x @` now calls `config.actions.execute_macro_over_visual_range`.
  - `<C-h/j/k/l>` now call `config.actions.move_window(...)`.
  - Snacks mappings now `require('snacks')` inside callbacks (avoids eager require in `mappings.lua`).
- Reduced keymap ownership confusion:
  - Removed conflicting `<leader>e` Neo-tree mapping from plugin spec (`lua/plugins/legacy.lua`).
  - Removed conflicting global `<leader>ff` mapping from `lua/config/mappings.lua`.
  - Moved Neo-tree reveal from `<leader>f` to `<leader>nr` to avoid conflict with format on `<leader>f`.
  - Moved `<leader>f` format mapping into `conform` plugin spec (`lua/plugins/legacy.lua`) so it is always available as a key-triggered plugin mapping.
  - Resulting ownership:
    - `<leader>f` => format (`conform`)
    - `<leader>ff` => find files (`snacks`)
    - `<leader>n` => Neo-tree toggle, `<leader>nr` => Neo-tree reveal
- Made setup more idempotent/Lua-native:
  - `lua/config/functions.lua` now uses named augroup handles with `clear = true` for custom and LSP progress autocmds.
  - `lua/lsp/on_attach.lua` now uses `nvim_create_autocmd` for signature help, buffer-scoped and de-duplicated.
  - `lua/helpers.lua` `buf_map()` now respects an explicit `buffer` option (falls back to current buffer only when not provided).
- Updated docs:
  - `nvim/.config/nvim/COMMANDS.md` updated for new/cleaned mappings and ownership.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/config/actions.lua nvim/.config/nvim/lua/config/functions.lua nvim/.config/nvim/lua/config/mappings.lua nvim/.config/nvim/lua/helpers.lua nvim/.config/nvim/lua/lsp/on_attach.lua nvim/.config/nvim/lua/plugins/legacy.lua` passed.
- `rg -n "ExecuteMacroOverVisualRange|WinMove\\(|function!|RangeSearch" nvim/.config/nvim/lua` returned no matches.
- `XDG_CONFIG_HOME=/Users/jeremy.monson/dotfiles/nvim/.config XDG_CACHE_HOME=$(mktemp -d /tmp/nvim-cache-cleanseq.XXXXXX) XDG_STATE_HOME=$(mktemp -d /tmp/nvim-state-cleanseq.XXXXXX) nvim --headless '+lua print("NVIM_BOOT_OK")' '+qa'` passed.
- `XDG_CONFIG_HOME=/Users/jeremy.monson/dotfiles/nvim/.config XDG_CACHE_HOME=$(mktemp -d /tmp/nvim-cache-cleanseq.XXXXXX) XDG_STATE_HOME=$(mktemp -d /tmp/nvim-state-cleanseq.XXXXXX) nvim --headless '+lua require("lsp")' '+qa'` passed.
- `... nvim --headless '+lua local a=require("config.actions"); vim.cmd("enew"); local before=#vim.api.nvim_tabpage_list_wins(0); a.move_window("l"); local after=#vim.api.nvim_tabpage_list_wins(0); print("WIN_MOVE_OK=" .. tostring(after > before) .. " BEFORE=" .. before .. " AFTER=" .. after)' '+qa'` returned `WIN_MOVE_OK=true BEFORE=1 AFTER=2`.
- Key ownership probe shows expected active normal-mode mappings:
  - `<Space>f` desc `Format file or range (in visual mode)`
  - `<Space>ff` desc `Find Files`
  - `<Space>fg` desc `Grep`
  - `<Space>n` desc `Toggle Neo-tree`
  - `<Space>nr` desc `Reveal current file in Neo-tree`

---

# Neovim Concern Separation Pass

## Goal

- Continue Neovim cleanup by grouping setup into concern-specific modules so responsibilities are obvious and easier to maintain.

## Acceptance Criteria

- Keymaps are organized into concern-based modules (`config/keymaps/*`) instead of one large mixed file.
- Command setup and autocmd setup are separated into dedicated modules.
- Main config load order remains explicit and behavior-compatible.
- Headless startup and key ownership probes still pass.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate existing implementation / patterns
- [x] Design: minimal approach + key decisions
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: config repo; using deterministic probes)
- [x] Run verification (stylua + headless Neovim + keymap probes)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Keep behavior stable while improving structure.
- Use compatibility shims for old module paths where practical to reduce blast radius.

## Results

- Split setup by concern:
  - Added `lua/config/commands.lua` for user commands.
  - Added `lua/config/autocmds.lua` for all custom autocmd logic.
  - Added `lua/config/keymaps/` module tree:
    - `core.lua`, `git.lua`, `search.lua`, `editing.lua`, `navigation.lua`, `terminal.lua`, `shared.lua`, and `init.lua`.
- Updated main load order:
  - `lua/config/init.lua` now loads `options -> commands -> autocmds -> keymaps`.
- Kept compatibility shims to reduce blast radius:
  - `lua/config/functions.lua` now delegates to `commands` + `autocmds`.
  - `lua/config/mappings.lua` now delegates to `config.keymaps`.
- Updated documentation:
  - `nvim/.config/nvim/COMMANDS.md` now references `commands.lua` and `config/keymaps/*.lua`.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/config/init.lua nvim/.config/nvim/lua/config/functions.lua nvim/.config/nvim/lua/config/mappings.lua nvim/.config/nvim/lua/config/commands.lua nvim/.config/nvim/lua/config/autocmds.lua nvim/.config/nvim/lua/config/keymaps/*.lua` passed.
- `XDG_CONFIG_HOME=/Users/jeremy.monson/dotfiles/nvim/.config XDG_CACHE_HOME=$(mktemp -d /tmp/nvim-cache-structure.XXXXXX) XDG_STATE_HOME=$(mktemp -d /tmp/nvim-state-structure.XXXXXX) nvim --headless '+lua print("NVIM_BOOT_OK")' '+qa'` passed.
- `XDG_CONFIG_HOME=/Users/jeremy.monson/dotfiles/nvim/.config XDG_CACHE_HOME=$(mktemp -d /tmp/nvim-cache-structure.XXXXXX) XDG_STATE_HOME=$(mktemp -d /tmp/nvim-state-structure.XXXXXX) nvim --headless '+lua require("config") ; print("CONFIG_OK")' '+qa'` passed.
- `XDG_CONFIG_HOME=/Users/jeremy.monson/dotfiles/nvim/.config XDG_CACHE_HOME=$(mktemp -d /tmp/nvim-cache-structure.XXXXXX) XDG_STATE_HOME=$(mktemp -d /tmp/nvim-state-structure.XXXXXX) nvim --headless '+lua require("lsp")' '+qa'` passed.
- Key ownership probe confirms core mappings are still present after split:
  - `<Space>f`, `<Space>ff`, `<Space>fg`, `<Space>n`, `<Space>nr`, `<Space>ps`, `<Space>ga`, `<Space>tt`.
- Callback probe confirms migrated Lua mappings still active:
  - visual `@` callback map present.
  - `<C-h/j/k/l>` callback maps present.
- Leader-key duplication probe returned `LEADER_DUP_COUNT=0`.

---

# Install Local Plugin: plugin-use-tracker

## Goal

- Install local Neovim plugin from `~/Desktop/nvim-plugin-use` so it can be tested in this config.

## Acceptance Criteria

- Plugin is declared in lazy plugin specs as a local path dependency.
- Plugin loads only when local directory exists (no hard failure on machines without it).
- `:PluginUseTrackerReport` and `:PluginUseTrackerReset` are available in a headless verification run.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate plugin path + module entrypoints
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: config repo; using deterministic probes)
- [x] Run verification (headless command existence probes)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Plugin provides module `plugin_use_tracker` and auto-setup via `plugin/plugin_use_tracker.lua`.
- Use guarded local path install to avoid breaking setups where `~/Desktop/nvim-plugin-use` does not exist.

## Results

- Installed local plugin in Neovim lazy specs:
  - Added guarded local path plugin entry in `nvim/.config/nvim/lua/plugins/editor.lua`:
    - `dir = vim.fn.expand('~/Desktop/nvim-plugin-use')`
    - `name = 'plugin-use-tracker.nvim'`
    - `lazy = false`
    - `enabled = function() return isdirectory(...) == 1 end`
- This enables immediate testing on this machine while avoiding hard failures on machines where that Desktop path is absent.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/plugins/editor.lua` passed.
- Headless command availability probe passed:
  - `HAS_REPORT=true`
  - `HAS_RESET=true`
- Headless report execution passed after overriding output path to writable temp:
  - `plugin-use-tracker wrote report: /tmp/.../report.json`

### Environment Note

- In this sandbox, default report output (`~/.local/share/nvim/plugin-use-tracker/report.json`) is not writable, which causes `VimLeavePre` write errors during automated checks.
- This is a sandbox restriction; in your normal local Neovim session it should write to your actual `stdpath("data")` directory.

---

# Neovim Low-Risk Cleanup Pass

## Goal

- Finish low-risk cleanup items from the recent Neovim reorganization pass without behavior changes.

## Acceptance Criteria

- Obsolete shim modules are removed (`config/functions.lua`, `config/mappings.lua`) and no active requires reference them.
- `:Browse` is defined in `lua/config/commands.lua` (not in options setup).
- Stale `nvim-tree` leftovers are removed from `lua/config/options.lua`.
- Python provider configuration avoids hard failures by conditionally selecting hosts and disabling py2 when absent.
- Formatting and deterministic headless checks pass.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate current definitions and stale references
- [x] Implement smallest safe slice
- [x] Add/adjust tests (N/A: config repo; deterministic probes used)
- [x] Run verification (stylua + headless Neovim probes)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Keep changes surgical and avoid broad plugin/load-order refactors.
- Use conditional provider detection so local machine differences do not break startup.

## Results

- Removed obsolete shim modules:
  - Deleted `nvim/.config/nvim/lua/config/functions.lua`.
  - Deleted `nvim/.config/nvim/lua/config/mappings.lua`.
- Moved command ownership to dedicated commands module:
  - `:Browse` is now defined in `nvim/.config/nvim/lua/config/commands.lua`.
  - Removed `:Browse` definition from `nvim/.config/nvim/lua/config/options.lua`.
- Cleaned stale `nvim-tree` leftovers:
  - Removed `nvim_tree_quit_on_open` setting and related commented legacy block from options.
- Hardened Python provider setup:
  - `nvim/.config/nvim/lua/config/options.lua` now checks executable paths before assigning:
    - py2 host is disabled when absent via `g.loaded_python_provider = 0`.
    - py3 host uses asdf path when available, otherwise falls back to `exepath('python3')`.
- Updated docs:
  - `nvim/.config/nvim/COMMANDS.md` now points `:Browse` to `lua/config/commands.lua`.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/config/options.lua nvim/.config/nvim/lua/config/commands.lua` passed.
- `rg -n "config\\.functions|config\\.mappings" nvim/.config/nvim/lua nvim/.config/nvim/init.lua` confirms no active runtime requires for removed shim modules.
- `rg -n "nvim_tree_" nvim/.config/nvim/lua/config/options.lua` returns no matches.
- Deterministic headless probe passed:
  - `nvim --clean --headless '+lua package.path = package.path .. ";/Users/jeremy.monson/dotfiles/nvim/.config/nvim/lua/?.lua;/Users/jeremy.monson/dotfiles/nvim/.config/nvim/lua/?/init.lua"' '+lua require("config.options"); require("config.commands"); print("HAS_BROWSE=" .. tostring(vim.fn.exists(":Browse") == 2)); print("HAS_LAZYSYNC=" .. tostring(vim.fn.exists(":LazySync") == 2)); print("PY2_PROVIDER_DISABLED=" .. tostring(vim.g.loaded_python_provider == 0)); print("PY3_HOST=" .. tostring(vim.g.python3_host_prog or ""))' +qa`
  - Output: `HAS_BROWSE=true`, `HAS_LAZYSYNC=true`, `PY2_PROVIDER_DISABLED=true`, `PY3_HOST=/Users/jeremy.monson/.asdf/installs/python/3.9.5/bin/python`.

---

# Neovim Consistency Cleanup Pass

## Goal

- Continue incremental Neovim cleanup by tightening key ownership consistency and isolating local-only tooling behavior.

## Acceptance Criteria

- `<leader>ff` behavior and description are aligned to file-finder intent.
- `<leader>l` ownership moves to plugin spec keys (discoverable and lazy-load-friendly), with no duplicate ad-hoc mapping in plugin config.
- Local plugin usage tracker is isolated from generic editor plugin specs and does not enable during headless sessions.
- Docs reflect keymap source-of-truth updates.
- Formatting and headless startup probes pass.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate current implementation and ownership conflicts
- [x] Design: smallest safe slice
- [x] Implement cleanup edits
- [x] Add/adjust tests (N/A: config repo; deterministic probes)
- [x] Run verification (stylua + headless Neovim probes)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Keep plugin behavior stable and avoid broad plugin-manager refactors.
- Prefer plugin `keys` ownership over ad-hoc `vim.keymap.set` in plugin config modules.

## Results

- Aligned `snacks` key ownership/intent:
  - `nvim/.config/nvim/lua/plugins/editor.lua` now maps `<leader>ff` to `picker.files()` with description `Find Files`.
- Moved local-only plugin tracking into a dedicated plugin module:
  - Added `nvim/.config/nvim/lua/plugins/local.lua` with `plugin-use-tracker.nvim` spec.
  - Tracker is now gated to interactive UI sessions (`#vim.api.nvim_list_uis() > 0`) and local path presence, avoiding headless tooling side effects.
  - Removed tracker spec from `nvim/.config/nvim/lua/plugins/editor.lua` to keep editor plugin concerns focused.
- Moved lint key ownership to plugin spec:
  - Added `<leader>l` key spec under `nvim-lint` in `nvim/.config/nvim/lua/plugins/legacy.lua`.
  - Removed ad-hoc `<leader>l` keymap from `nvim/.config/nvim/lua/plugin_configs/lint.lua`.
- Updated docs source ownership:
  - `nvim/.config/nvim/COMMANDS.md` now lists `<leader>l` source as `lua/plugins/legacy.lua`.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/plugins/editor.lua nvim/.config/nvim/lua/plugins/local.lua nvim/.config/nvim/lua/plugins/legacy.lua nvim/.config/nvim/lua/plugin_configs/lint.lua` passed.
- Headless startup probe passed:
  - `XDG_CONFIG_HOME=/Users/jeremy.monson/dotfiles/nvim/.config XDG_CACHE_HOME=$(mktemp -d /tmp/nvim-cache-cleanup2.XXXXXX) XDG_STATE_HOME=$(mktemp -d /tmp/nvim-state-cleanup2.XXXXXX) nvim --headless '+lua print("NVIM_BOOT_OK")' '+qa'`
  - Output: `NVIM_BOOT_OK`.
- Key/command behavior probe passed:
  - `FF_DESC=Find Files`
  - `L_DESC=Trigger linting for current file`
  - `HAS_PLUGIN_USE_REPORT_CMD=false` (expected in headless mode)
- Ownership probes:
  - `rg -n "plugin-use-tracker|Desktop/nvim-plugin-use" nvim/.config/nvim/lua/plugins` shows tracker spec only in `lua/plugins/local.lua`.
  - `rg -n "<leader>l|try_lint\\(" nvim/.config/nvim/lua/plugins/legacy.lua nvim/.config/nvim/lua/plugin_configs/lint.lua` shows key ownership in plugin spec, with config module retaining autocmd-based linting only.

---

# Neovim Plugin Spec Concern Split Pass

## Goal

- Continue cleanup by reducing `lua/plugins/legacy.lua` scope and grouping plugin specs by concern without changing behavior.

## Acceptance Criteria

- Treesitter/syntax-related specs are moved from `lua/plugins/legacy.lua` into a dedicated concern file.
- Formatting/lint specs are moved from `lua/plugins/legacy.lua` into a dedicated concern file.
- `lua/plugins/legacy.lua` remains focused on remaining legacy/editor UI specs.
- `COMMANDS.md` plugin keymap source rows remain accurate after moves.
- `stylua --check` and headless startup/key probes pass.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate current plugin spec groupings
- [x] Design: minimal split strategy
- [x] Implement concern file split
- [x] Update docs for moved keymap sources
- [x] Run verification (stylua + headless probes)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Keep plugin declarations identical while relocating them.
- Avoid plugin duplication across files during split.

## Results

- Split plugin specs by concern:
  - Added `nvim/.config/nvim/lua/plugins/quality.lua` for:
    - `stevearc/conform.nvim` (format keymap `<leader>f`)
    - `mfussenegger/nvim-lint` (lint keymap `<leader>l`)
  - Added `nvim/.config/nvim/lua/plugins/syntax.lua` for:
    - `nvim-treesitter/nvim-treesitter`
    - `nvim-treesitter/playground`
    - `HiPhish/rainbow-delimiters.nvim`
    - `windwp/nvim-ts-autotag`
- Reduced `nvim/.config/nvim/lua/plugins/legacy.lua` scope:
  - Removed conform/lint and treesitter-related specs from `legacy.lua`.
  - Kept remaining legacy/editor UI specs intact (lualine, autopairs, bufferline, gitsigns, neo-tree, flash).
- Updated plugin keymap source docs:
  - `nvim/.config/nvim/COMMANDS.md` now points `<leader>f` and `<leader>l` to `lua/plugins/quality.lua`.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/plugins/legacy.lua nvim/.config/nvim/lua/plugins/quality.lua nvim/.config/nvim/lua/plugins/syntax.lua` passed.
- Ownership probe confirms moved specs are no longer in `legacy.lua`:
  - `rg -n "conform.nvim|nvim-lint|nvim-treesitter|playground|rainbow-delimiters|nvim-ts-autotag" nvim/.config/nvim/lua/plugins/legacy.lua nvim/.config/nvim/lua/plugins/quality.lua nvim/.config/nvim/lua/plugins/syntax.lua`
  - Output shows all matches only in `quality.lua` and `syntax.lua`.
- Headless startup probe passed:
  - `XDG_CONFIG_HOME=/Users/jeremy.monson/dotfiles/nvim/.config XDG_CACHE_HOME=$(mktemp -d /tmp/nvim-cache-split.XXXXXX) XDG_STATE_HOME=$(mktemp -d /tmp/nvim-state-split.XXXXXX) nvim --headless '+lua print("NVIM_BOOT_OK")' '+qa'`
  - Output: `NVIM_BOOT_OK`.
- Key probe passed:
  - `F_DESC=Format file or range (in visual mode)`
  - `L_DESC=Trigger linting for current file`
  - `HAS_PLUGIN_USE_REPORT_CMD=false` (expected headless behavior from local plugin gating).

---

# Neovim Tooling + Spec Consolidation Pass

## Goal

- Implement the next cleanup wave end-to-end:
  - add a repeatable headless Neovim smoke checker,
  - finish splitting remaining `legacy.lua` concerns,
  - inline trivial plugin config modules to reduce indirection.

## Acceptance Criteria

- New `bin/nvim-smoke` exists and exits non-zero when core invariants fail.
- `lua/plugins/legacy.lua` is removed by relocating remaining specs to concern files (`ui.lua`, `editor.lua`).
- Trivial plugin config modules are inlined into plugin specs and removed when unused.
- `COMMANDS.md` source references remain accurate.
- `stylua --check`, headless boot probes, and `bin/nvim-smoke` all pass.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate current specs and plugin config modules
- [x] Design: minimal safe migration strategy
- [x] Implement `bin/nvim-smoke`
- [x] Relocate remaining `legacy.lua` specs and remove file
- [x] Inline trivial plugin configs + prune dead modules
- [x] Update docs and notes
- [x] Run verification (stylua + headless probes + smoke script)
- [x] Summarize changes + verification story
- [ ] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Working Notes

- Preserve all existing key semantics (`<leader>ff` grep hidden/no-regex is mandatory).
- Keep complex plugin configs (`neo-tree`, `nvim-treesitter`) modular unless changes are clearly low-risk.

## Results

- Added repeatable Neovim smoke tool:
  - New executable `bin/nvim-smoke` validates boot/runtime invariants in headless mode.
  - Checks include:
    - `:Browse` and `:LazySync` command presence.
    - `<leader>ff` callback + exact expected description (`grep` hidden/no-regex behavior).
    - `<leader>f` and `<leader>l` description invariants.
    - headless gating for `plugin-use-tracker` (`:PluginUseTrackerReport` absent).
- Completed concern split by removing remaining `legacy.lua` usage:
  - Deleted `nvim/.config/nvim/lua/plugins/legacy.lua`.
  - Moved UI specs into `nvim/.config/nvim/lua/plugins/ui.lua`:
    - `nvim-lualine/lualine.nvim`
    - `akinsho/nvim-bufferline.lua`
    - `lewis6991/gitsigns.nvim`
    - `nvim-neo-tree/neo-tree.nvim`
  - Moved editing specs into `nvim/.config/nvim/lua/plugins/editor.lua`:
    - `windwp/nvim-autopairs`
    - `folke/flash.nvim`
- Inlined trivial plugin config modules into specs and pruned dead files:
  - Inlined `lualine`, `bufferline`, `gitsigns` setup into `plugins/ui.lua`.
  - Inlined `autopairs` setup and `flash` keys in `plugins/editor.lua`.
  - Inlined `conform` + `lint` config logic into `plugins/quality.lua`.
  - Deleted unused modules:
    - `lua/plugin_configs/autopairs.lua`
    - `lua/plugin_configs/bufferline.lua`
    - `lua/plugin_configs/conform.lua`
    - `lua/plugin_configs/gitsigns.lua`
    - `lua/plugin_configs/lint.lua`
    - `lua/plugin_configs/lualine.lua`
  - Kept complex modular files intact:
    - `lua/plugin_configs/neo-tree.lua`
    - `lua/plugin_configs/nvim-treesitter.lua`
- Updated documentation source references:
  - `nvim/.config/nvim/COMMANDS.md` now points flash keymaps to `lua/plugins/editor.lua`.
  - `README.md` now documents `make nvim-smoke`.
  - `Makefile` now includes `nvim-smoke` target (`./bin/nvim-smoke`).

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/plugins/editor.lua nvim/.config/nvim/lua/plugins/ui.lua nvim/.config/nvim/lua/plugins/quality.lua nvim/.config/nvim/lua/plugins/syntax.lua` passed.
- `bash -n bin/nvim-smoke` passed.
- Stale reference probes:
  - `rg -n "plugin_configs\\.(autopairs|bufferline|conform|gitsigns|lint|lualine)" nvim/.config/nvim/lua` returned no matches.
  - `rg -n "plugins/legacy\\.lua|lua/plugins/legacy.lua|legacy\\.lua" nvim/.config/nvim/COMMANDS.md nvim/.config/nvim/lua` returned no matches.
- Headless startup probe:
  - `NVIM_BOOT_OK`.
- Headless key/command probe:
  - `FF_DESC=Grep with no regex and show hidden files`
  - `F_DESC=Format file or range (in visual mode)`
  - `L_DESC=Trigger linting for current file`
  - `HAS_BROWSE=true`
  - `HAS_LAZYSYNC=true`
  - `HAS_PLUGIN_USE_REPORT_CMD=false`
- Smoke script output:
  - all checks printed `[PASS]`, ending with `[PASS] nvim smoke checks passed`.
- `make nvim-smoke` passed and produced the same all-`[PASS]` output.

---

# Neovim Insert-Mode Doc Focus Bugfix

## Goal

- Stop insert-mode LSP/completion documentation from stealing focus and pulling the editor out of insert mode.

## Acceptance Criteria

- No automatic insert-mode signature help float is opened from local config.
- Noice no longer overrides CMP documentation rendering.
- Noice automatic signature-help opening is disabled.
- Smoke checks cover the Noice insert-mode doc settings.

## Checklist

- [x] Restate goal + acceptance criteria
- [x] Locate insert-mode doc/hover triggers
- [x] Implement minimal safe fix
- [x] Add regression coverage to smoke checks
- [x] Run verification
- [x] Summarize changes + verification story
- [x] Record lessons (if any)
- [ ] Update `STYLEGUIDE.md` with anything learned and not already covered (N/A: file not present)

## Results

- Removed local insert-mode signature-help autocmd from `nvim/.config/nvim/lua/lsp/on_attach.lua`.
- Updated `nvim/.config/nvim/lua/plugins/ui.lua` Noice config:
  - `lsp.override["cmp.entry.get_documentation"] = false`
  - `lsp.signature.auto_open.enabled = false`
- Extended `bin/nvim-smoke` to assert:
  - `on_attach.lua` no longer registers the `CursorHoldI` insert-mode signature-help path
  - the Noice plugin spec still sets CMP documentation override to `false`
  - the Noice plugin spec still sets signature `auto_open.enabled = false`
- Recorded the prevention rule in `tasks/lessons.md`.

### Verification Evidence

- `stylua --check nvim/.config/nvim/lua/lsp/on_attach.lua nvim/.config/nvim/lua/plugins/ui.lua` passed.
- `bash -n bin/nvim-smoke` passed.
- `make nvim-smoke` passed.
- Smoke output confirms:
  - local `on_attach.lua` no longer contains `CursorHoldI` or automatic `vim.lsp.buf.signature_help`
  - Noice CMP documentation override is `false`
  - Noice signature auto-open is `false`
