local function on_attach(client)
  require 'illuminate'.on_attach(client)
end

require'lspconfig'.tsserver.setup{ on_attach=on_attach }
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

local cmd = vim.cmd

cmd "let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']"
cmd "nnoremap <leader>dd :lua vim.lsp.buf.definition()<CR>"
cmd "nnoremap <leader>df :lua vim.lsp.buf.implementation()<CR>"
cmd "nnoremap <leader>dt :lua vim.lsp.buf.signature_help()<CR>"
cmd "nnoremap <leader>dr :lua vim.lsp.buf.references()<CR>"
cmd "nnoremap <leader>drr :lua vim.lsp.buf.rename()<CR>"
cmd "nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>"
cmd "nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>"
cmd "nnoremap <leader>cs :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>"
cmd "nnoremap <leader>dn :lua vim.lsp.diagnostic.goto_next()<CR>"
cmd "nnoremap <leader>dp :lua vim.lsp.diagnostic.goto_prev()<CR>"
