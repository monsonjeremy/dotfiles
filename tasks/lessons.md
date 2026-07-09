# Lessons

## 2026-02-25

- Failure mode: advised shell sourcing steps before ensuring dotfiles were actually stowed into `$HOME`, and missed that helper scripts were not portable under `sh`.
- Detection signal: user saw `source: no such file or directory: /Users/jeremy.monson/.zshenv` plus `pushd/popd` errors when running `sh stow.sh` and `sh cleanenv.sh`.
- Prevention rule: before giving shell reload steps, verify bootstrap scripts with the user's invocation style and confirm symlink creation path (`~/.zshenv`, `~/.zshrc`) is in place.
- Failure mode: replaced `pushd/popd` entirely instead of preserving user-preferred workflow while fixing compatibility.
- Detection signal: user explicitly asked why `pushd` could not be used.
- Prevention rule: treat shell-style preferences as requirements when possible; keep preferred commands and add compatibility shims rather than removing them.
- Failure mode: initially validated `typecheck` from the wrong package path in a monorepo (`web` root instead of `apps/ops/mkt`).
- Detection signal: user clarified "in the mkt app".
- Prevention rule: when triaging command hangs in monorepos, confirm exact workspace path and script ownership before drawing conclusions.
- Failure mode: over-attributed `bun run typecheck` hangs to shell startup despite user reporting Claude-specific behavior.
- Detection signal: user explicitly corrected that terminal runs are fine and only Claude Code appears to hang; Claude session logs showed `bash_progress` with `totalLines: 0` followed by background task kill events.
- Prevention rule: when user scopes a hang to a specific runner (Claude, CI, IDE), treat runner behavior as primary and verify with runner logs before proposing shell-level root causes.

## 2026-02-26

- Failure mode: changed a user-established key behavior (`<leader>ff`) during cleanup without preserving the original intent.
- Detection signal: user explicitly requested to stop changing `<leader>ff` away from grep-with-hidden/no-regex behavior.
- Prevention rule: treat user keybinding semantics as hard requirements; only refactor ownership/structure unless the user asks to change behavior.

## 2026-03-03

- Failure mode: enabled insert-mode signature-help hover without setting the floating window to non-focusable, causing docs to steal focus while typing.
- Detection signal: user reported insert-mode hovering opens and focuses documentation unexpectedly.
- Prevention rule: when adding `CursorHoldI` signature help, always pass `{ focusable = false }` (and verify insert-mode UX directly).

## 2026-03-17

- Failure mode: left multiple automatic insert-mode documentation paths enabled (`CursorHoldI` signature help and Noice CMP/signature overrides), allowing float focus regressions to persist even after a local fix.
- Detection signal: user reported being pulled out of insert mode into a hover-style/type-definition window.
- Prevention rule: keep insert-mode documentation opt-in; disable automatic signature help and CMP doc overrides unless they are explicitly desired and verified not to steal focus.

## 2026-04-06

- Failure mode: attributed picker-open freezing to general `BufRead` plugin fan-out without first confirming which picker implementation the user was actually using and tracing that picker's select/open path.
- Detection signal: user explicitly clarified they are using `snacks` and reported the hang still persists after the generic lazy-loading changes.
- Prevention rule: when debugging picker or opener freezes in Neovim, identify the exact picker plugin first and inspect its configured open action and preview pipeline before optimizing unrelated buffer-load hooks.
