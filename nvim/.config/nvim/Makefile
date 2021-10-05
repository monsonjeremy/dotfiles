.DEFAULT_GOAL = check

onedark_path = lua

format:
	stylua -g '*.lua' -g '!packer_compiled.lua' --config-path '../../../stylua.toml' -- .

lint: $(onedark_path)
	@luacheck $(onedark_path)

check: format lint
