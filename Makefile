.DEFAULT_GOAL = check

format:
	@stylua -g '*.lua' -- ./nvim/.config/nvim

lint:
	@luacheck .

check: format lint
