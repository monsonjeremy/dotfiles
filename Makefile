.DEFAULT_GOAL = check

format:
	@stylua -g '*.lua' -g '!packer_compiled.lua' -- .

lint:
	@luacheck . --exclude-files '**/packer_compiled.lua'

check: format lint
