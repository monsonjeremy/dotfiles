.DEFAULT_GOAL = check

format:
	@stylua -g '*.lua' -- ./nvim/.config/nvim

format-check:
	@stylua --check -g '*.lua' -- ./nvim/.config/nvim

lint:
	@if ! command -v luacheck >/dev/null 2>&1 || ! luacheck --version >/dev/null 2>&1; then \
		echo "luacheck is missing or broken. Run 'brew install luacheck' (or reinstall via luarocks)." >&2; \
		exit 1; \
	fi
	@luacheck .

doctor:
	@./bin/dotfiles-doctor

nvim-smoke:
	@./bin/nvim-smoke

check: format-check lint
