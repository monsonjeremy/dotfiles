print('entering null-ls')
local present, null_ls = pcall(require, 'null-ls')
if not present then
  return
end

local eslint = require('lsp.servers.null-ls.eslint')

local styluaConfig = {
  extra_args = { '--config-path', vim.fn.expand('~/dotfiles/stylua.toml') },
}

local styleLintFormattingConfig = {
  extra_args = {
    '--config',
    vim.fn.expand('~/dotfiles/.stylelintrc.json'),
  },
}

local styleLintDiagnosticsConfig = {
  extra_args = {
    '--config',
    vim.fn.expand('~/dotfiles/.stylelintrc.json'),
  },
}

local luaCheckConfig = {
  extra_args = {
    '--config',
    vim.fn.expand('~/dotfiles/.luacheckrc'),
    '--globals vim bufnr',
  },
}

null_ls.config({
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.eslintd,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.stylua.with(styluaConfig),
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylelint.with(styleLintFormattingConfig),
    null_ls.builtins.formatting.eslint_d.with(eslint.eslintConfig),
    null_ls.builtins.diagnostics.luacheck.with(luaCheckConfig),
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.stylelint.with(styleLintDiagnosticsConfig),
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.eslint_d.with(eslint.eslintConfig),
    null_ls.builtins.code_actions.eslint_d.with(eslint.eslintConfig),
    null_ls.builtins.code_actions.gitsigns
  },
})
