.DEFAULT_GOAL = check

onedark_path = lua

format:
	@for file in `find ./lua -name '*.lua'`;do lua-format $$file -i; done;

lint: $(onedark_path)
	@luacheck $(onedark_path)

check: format lint
