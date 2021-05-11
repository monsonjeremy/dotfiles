require'lspinstall'.setup()
local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{}
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

local function on_attach(client)
  require 'illuminate'.on_attach(client)
end

require'lspconfig'.tsserver.setup{
  on_attach=on_attach,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}
require'lspconfig'.pyls.setup{ on_attach=on_attach }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require'lspconfig'.rust_analyzer.setup{
  on_attach=on_attach,
  capabilities=capabilities
}

require'lspconfig'.jsonls.setup {
  on_attach=on_attach,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}
require'lspconfig'.dotls.setup{ on_attach=on_attach }
require'lspconfig'.terraformls.setup{ on_attach=on_attach }
require'lspconfig'.tsserver.setup{ on_attach=on_attach }
require'lspconfig'.vimls.setup{ on_attach=on_attach}
require('lspfuzzy').setup {}

local opts = {
  -- whether to highlight the currently hovered symbol
  -- disable if your cpu usage is higher than you want it
  -- or you just hate the highlight
  -- default: true
  highlight_hovered_item = true,

  -- whether to show outline guides
  -- default: true
  show_guides = true,
}

require('symbols-outline').setup(opts)
local saga = require 'lspsaga'

local cmd = vim.cmd

cmd "let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']"
cmd "nnoremap <leader>dd :lua vim.lsp.buf.definition()<CR>"
cmd "nnoremap <leader>df :lua vim.lsp.buf.implementation()<CR>"
cmd "nnoremap <leader>dt :lua vim.lsp.buf.signature_help()<CR>"
cmd "nnoremap <leader>dr :lua vim.lsp.buf.references()<CR>"
cmd "nnoremap <leader>drr :Lspsaga rename<CR><CR>"
cmd "nnoremap <silent> <leader>pd :Lspsaga preview_definition<CR>"
cmd "nnoremap <leader>sh :Lspsaga signature_help<CR>"
cmd "nnoremap <silent> K :Lspsaga hover_doc<CR>"
cmd "nnoremap <leader>cs :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>"
cmd "nnoremap <leader>dn :Lspsaga diagnostic_jump_next<CR>"
cmd "nnoremap <leader>dp :Lspsaga diagnostic_jump_prev<CR>"
cmd "nnoremap <silent><leader>ca :Lspsaga code_action<CR>"
cmd "vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>"

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "",
      spacing = 0,
    },
    signs = true,
    underline = true,
  }
)

