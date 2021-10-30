.DEFAULT_GOAL = check

format:
	@stylua -g '*.lua' -g '!packer_compiled.lua' -- ./nvim/.config/nvim

lint:
	@luacheck . --exclude-files '**/packer_compiled.lua'

check: format lint
