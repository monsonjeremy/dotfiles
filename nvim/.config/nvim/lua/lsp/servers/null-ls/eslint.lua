local util = require('lspconfig/util')
local m = {}

local lookForPackageJson = function(params)
  return util.root_pattern('Makefile', '.git', 'package.json')(params.bufname)
end

local eslintFormattingConfig = {
  only_local = 'node_modules/.bin',
  use_cache = true,
  cwd = lookForPackageJson,
  diagnostics_format = '#{m} [#{c}]',
  args = {
    '--cache',
    '--fix-to-stdout',
    '--stdin',
    '--stdin-filename',
    '$FILENAME',
  },
}

local eslintDiagnosticsConfig = {
  only_local = 'node_modules/.bin',
  use_cache = true,
  cwd = lookForPackageJson,
  diagnostics_format = '#{m} [#{c}]',
  args = {
    '--cache',
    '-f',
    'json',
    '--stdin',
    '--stdin-filename',
    '$FILENAME',
  },
}

local eslintConfig = {
  only_local = 'node_modules/.bin',
  cwd = lookForPackageJson,
  diagnostics_format = '#{m} [#{c}]',
}

m.eslintConfig = eslintConfig

return m
