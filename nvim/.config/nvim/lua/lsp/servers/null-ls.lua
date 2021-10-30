local present, null_ls = pcall(require, 'null-ls')
if not present then
  return
end

null_ls.config({
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.stylua.with({
      extra_args = { '--config-path', vim.fn.expand('~/dotfiles/stylua.toml') },
    }),
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylelint.with({
      extra_args = {
        '--config',
        vim.fn.expand('~/dotfiles/.stylelintrc.json'),
      },
    }),
    null_ls.builtins.diagnostics.luacheck.with({
      extra_args = {
        '--config',
        vim.fn.expand('~/dotfiles/.luacheckrc'),
        '--globals vim bufnr',
      },
    }),
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.stylelint.with({
      extra_args = {
        '--config',
        vim.fn.expand('~/dotfiles/.stylelintrc.json'),
      },
    }),
    null_ls.builtins.diagnostics.hadolint,
  },
})
