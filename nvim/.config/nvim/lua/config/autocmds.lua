local custom_group = vim.api.nvim_create_augroup('JeremyCustom', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
  group = custom_group,
  pattern = '*',
  callback = function(args)
    vim.opt.formatoptions = vim.opt.formatoptions - { 'o' }
    vim.bo[args.buf].formatexpr = nil
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  group = custom_group,
  pattern = '*',
  callback = function()
    vim.go.laststatus = 3
  end,
  once = true,
})

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
local lsp_progress_group = vim.api.nvim_create_augroup('JeremyLspProgress', { clear = true })
local ignored_progress_clients = {
  ['eslint'] = true,
  ['typescript-tools'] = true,
}

vim.api.nvim_create_autocmd('LspProgress', {
  group = lsp_progress_group,
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or ignored_progress_clients[client.name] or type(value) ~= 'table' then
      return
    end

    local message = value.message
    if message == value.title then
      message = nil
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ('[%3d%%] %s%s'):format(
            value.kind == 'end' and 100 or value.percentage or 100,
            value.title or '',
            message and (' **%s**'):format(message) or ''
          ),
          done = value.kind == 'end',
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    vim.notify(table.concat(msg, '\n'), 'info', {
      id = 'lsp_progress',
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and ' '
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
