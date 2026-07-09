local uv = vim.uv or vim.loop

local candidate_names = {
  ['app.css'] = true,
  ['base.css'] = true,
  ['globals.css'] = true,
  ['index.css'] = true,
  ['main.css'] = true,
  ['styles.css'] = true,
  ['tailwind.css'] = true,
}

local ignored_dirs = {
  ['.claude'] = true,
  ['.git'] = true,
  ['.next'] = true,
  ['.turbo'] = true,
  ['.worktrees'] = true,
  ['build'] = true,
  ['coverage'] = true,
  ['dist'] = true,
  ['node_modules'] = true,
}

local function read_file(path)
  local stat = uv.fs_stat(path)
  if not stat or stat.type ~= 'file' or stat.size > 256 * 1024 then
    return nil
  end

  local fd = io.open(path, 'r')
  if not fd then
    return nil
  end

  local ok, content = pcall(fd.read, fd, '*a')
  fd:close()
  return ok and content or nil
end

local function is_ignored(path)
  for dir in pairs(ignored_dirs) do
    if path:find('/' .. dir .. '/') then
      return true
    end
  end
  return false
end

local function has_tailwind_import(path)
  local content = read_file(path)
  if not content then
    return false
  end

  return content:find('@import%s+["\']tailwindcss["\']%s*;?')
    or content:find('@tailwind%s+base%s*;')
    or content:find('@tailwind%s+utilities%s*;')
end

local function find_tailwind_entrypoint(root)
  if not root or root == '' then
    return nil
  end

  local matches = vim.fs.find(function(name, path)
    if not candidate_names[name] then
      return false
    end

    local full_path = path and (path .. '/' .. name) or name
    return not is_ignored(full_path)
  end, {
    limit = 25,
    path = root,
    type = 'file',
  })

  for _, path in ipairs(matches) do
    if has_tailwind_import(path) then
      return path
    end
  end

  return nil
end

vim.lsp.config('tailwindcss', {
  before_init = function(_, config)
    config.settings = config.settings or {}
    config.settings.editor = config.settings.editor or {}
    config.settings.tailwindCSS = config.settings.tailwindCSS or {}
    config.settings.tailwindCSS.experimental = config.settings.tailwindCSS.experimental or {}

    if not config.settings.editor.tabSize then
      config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
    end

    if not config.settings.tailwindCSS.experimental.configFile then
      config.settings.tailwindCSS.experimental.configFile =
        find_tailwind_entrypoint(config.root_dir)
    end
  end,
})
