local util = require('lspconfig/util')
local m = {}

local lookForPackageJson = function(params)
  return util.root_pattern('.eslintrc*', '.git', 'node_modules')(params.bufname)
end

local eslintConfig = {
  cwd = lookForPackageJson,
  diagnostics_format = '#{m} [#{c}]',
  use_cache = true,
  -- condition = function(utils)
  --   return utils.root_has_file('.eslintrc')
  --     or utils.root_has_file('.eslintrc.json')
  --     or utils.root_has_file('.eslintrc.yaml')
  --     or utils.root_has_file('.eslintrc.js')
  -- end,
}

local eslintFormattingConfig = {
  cwd = lookForPackageJson,
}

m.eslintConfig = eslintConfig
m.eslintFormattingConfig = eslintFormattingConfig

return m
