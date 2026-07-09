local present, treesitter = pcall(require, 'nvim-treesitter.configs')
if not present then
  return
end

local function install_query_predicate_compat()
  if vim.fn.has('nvim-0.12') ~= 1 then
    return
  end

  local query = require('vim.treesitter.query')
  local opts = { force = true }

  -- Temporary bridge for old nvim-treesitter master on Neovim 0.12.
  -- Remove this when migrating to the rewritten nvim-treesitter setup.
  local html_script_type_languages = {
    ['application/ecmascript'] = 'javascript',
    importmap = 'json',
    module = 'javascript',
    ['text/ecmascript'] = 'javascript',
  }

  local non_filetype_match_injection_language_aliases = {
    ex = 'elixir',
    pl = 'perl',
    sh = 'bash',
    ts = 'typescript',
    uxn = 'uxntal',
  }

  local function node_for_capture(match, capture_id)
    local capture = match[capture_id]

    if type(capture) == 'table' then
      return capture[1]
    end

    return capture
  end

  local function get_parser_from_markdown_info_string(injection_alias)
    local match = vim.filetype.match({ filename = 'a.' .. injection_alias })
    return match
      or non_filetype_match_injection_language_aliases[injection_alias]
      or injection_alias
  end

  local function valid_args(name, pred, count, strict_count)
    local arg_count = #pred - 1

    if strict_count and arg_count ~= count then
      vim.api.nvim_err_writeln(string.format('%s must have exactly %d arguments', name, count))
      return false
    end

    if not strict_count and arg_count < count then
      vim.api.nvim_err_writeln(string.format('%s must have at least %d arguments', name, count))
      return false
    end

    return true
  end

  query.add_predicate('nth?', function(match, _pattern, _bufnr, pred)
    if not valid_args('nth?', pred, 2, true) then
      return
    end

    local node = node_for_capture(match, pred[2])
    local n = tonumber(pred[3])
    if node and node:parent() and node:parent():named_child_count() > n then
      return node:parent():named_child(n) == node
    end

    return false
  end, opts)

  query.add_predicate('is?', function(match, _pattern, bufnr, pred)
    if not valid_args('is?', pred, 2) then
      return
    end

    local locals = require('nvim-treesitter.locals')
    local node = node_for_capture(match, pred[2])
    local types = { unpack(pred, 3) }

    if not node then
      return true
    end

    local _, _, kind = locals.find_definition(node, bufnr)
    return vim.tbl_contains(types, kind)
  end, opts)

  query.add_predicate('kind-eq?', function(match, _pattern, _bufnr, pred)
    if not valid_args(pred[1], pred, 2) then
      return
    end

    local node = node_for_capture(match, pred[2])
    local types = { unpack(pred, 3) }

    if not node then
      return true
    end

    return vim.tbl_contains(types, node:type())
  end, opts)

  query.add_directive('set-lang-from-mimetype!', function(match, _, bufnr, pred, metadata)
    local node = node_for_capture(match, pred[2])
    if not node then
      return
    end

    local type_attr_value = vim.treesitter.get_node_text(node, bufnr)
    local configured = html_script_type_languages[type_attr_value]

    if configured then
      metadata['injection.language'] = configured
    else
      local parts = vim.split(type_attr_value, '/', {})
      metadata['injection.language'] = parts[#parts]
    end
  end, opts)

  query.add_directive('set-lang-from-info-string!', function(match, _, bufnr, pred, metadata)
    local node = node_for_capture(match, pred[2])
    if not node then
      return
    end

    local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
    metadata['injection.language'] = get_parser_from_markdown_info_string(injection_alias)
  end, opts)

  query.add_directive('downcase!', function(match, _, bufnr, pred, metadata)
    local id = pred[2]
    local node = node_for_capture(match, id)
    if not node then
      return
    end

    local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ''
    metadata[id] = metadata[id] or {}
    metadata[id].text = string.lower(text)
  end, opts)
end

treesitter.setup({
  autopairs = { enable = true },
  rainbow = {
    max_file_lines = 2000,
    enable = true,
    -- Which query to use for finding delimiters
    query = 'rainbow-delimiters',
    -- Highlight the entire buffer all at once
    strategy = require('rainbow-delimiters').strategy.global,
  },
  ensure_installed = {
    'bash',
    'comment',
    'css',
    'dockerfile',
    'dot',
    'eex',
    'elixir',
    'erlang',
    'fennel',
    'gleam',
    'go',
    'graphql',
    'hcl',
    'heex',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'lua',
    'prisma',
    'python',
    'regex',
    'rust',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  highlight = { enable = true, use_languagetree = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
})

install_query_predicate_compat()
