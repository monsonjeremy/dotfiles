local present, null_ls = pcall(require, 'null-ls')
if not present then
  return
end

local on_attach = require('lsp.on_attach')

local styluaConfig = {
  extra_args = { '--config-path', vim.fn.expand('~/dotfiles/stylua.toml') },
}

local mixFormatConfig = {
  filetypes = { 'elixir', 'heex' },
}

local luaCheckConfig = {
  extra_args = {
    '--config',
    vim.fn.expand('~/dotfiles/.luacheckrc'),
  },
}

local credoConfig = {
  env = {
    MIX_ENV = 'test',
  },
}

local luacheck = require('none-ls-luacheck.diagnostics.luacheck')

null_ls.setup({
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    on_attach(client)
  end,
  sources = {
    -- null_ls.builtins.formatting.biome,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylua.with(styluaConfig),
    null_ls.builtins.formatting.mix.with(mixFormatConfig),
    -- null_ls.builtins.formatting.prismaFmt,
    luacheck.with(luaCheckConfig),
    null_ls.builtins.diagnostics.dotenv_linter,
    null_ls.builtins.diagnostics.hadolint,
    -- null_ls.builtins.diagnostics.credo.with(credoConfig),
    -- null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.prettierd,
    -- null_ls.builtins.code_actions.refactoring,
  },
})
