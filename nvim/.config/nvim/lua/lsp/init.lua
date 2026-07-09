local present_lspconfig = pcall(require, 'lspconfig')
local present_mason, mason = pcall(require, 'mason')
local present_mason_lsp, masonLSP = pcall(require, 'mason-lspconfig')
if not (present_lspconfig and present_mason and present_mason_lsp) then
  return
end

local lsp = vim.lsp

mason.setup({
  log_level = vim.log.levels.DEBUG,
})

masonLSP.setup({
  ensure_installed = {
    'bashls',
    'cssls',
    'html',
    'jsonls',
    'lua_ls',
    'rust_analyzer',
    -- 'ts_ls', -- disabled: using typescript-tools.nvim instead
    'vimls',
    'graphql',
    'terraformls',
    'tflint',
    'prismals',
    'expert',
    'dockerls',
    'stylelint_lsp',
    'eslint',
    'cssmodules_ls',
    'tailwindcss',
  },
  automatic_enable = {
    exclude = {
      'elixirls',
      'nextls',
      'lexical',
    },
  },
})

local function set_sign(type, icon)
  local sign = string.format('DiagnosticSign%s', type)
  local texthl = string.format('DiagnosticDefault%s', type)
  vim.fn.sign_define(sign, { text = icon, texthl = texthl })
end

set_sign('Hint', '')
set_sign('Info', '')
set_sign('Warning', '')
set_sign('Error', '⊗')

lsp.set_log_level('warn')
if lsp.inlay_hint and lsp.inlay_hint.enable then
  pcall(lsp.inlay_hint.enable)
end

vim.diagnostic.config({
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = { prefix = '●', spacing = 2, severity = { min = vim.diagnostic.severity.WARN } },
  signs = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
})

-- Disable code action lightbulb icon in status column
-- Remove lightbulb signs whenever they appear
vim.api.nvim_create_autocmd({ 'LspAttach' }, {
  callback = function(args)
    local bufnr = args.buf
    -- Remove lightbulb signs on cursor hold
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = bufnr,
      callback = function()
        local signs = vim.fn.sign_getplaced(bufnr, { group = '*' })
        if signs[1] and signs[1].signs then
          for _, sign in ipairs(signs[1].signs) do
            -- Check for lightbulb sign by name
            if sign.name and (sign.name:match('LightBulb') or sign.name:match('CodeAction')) then
              vim.fn.sign_unplace(sign.group or '*', { id = sign.id, buffer = bufnr })
            end
          end
        end
      end,
    })
  end,
})

require('lsp.servers')
