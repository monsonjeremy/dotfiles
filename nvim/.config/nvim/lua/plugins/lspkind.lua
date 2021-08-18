local present, lspkind = pcall(require, 'lspkind')
if not present then return end

lspkind.init({
  with_text = false, -- Below are defaults
  symbol_map = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Variable = '',
    Class = '',
    Interface = 'ﰮ',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '了',
    Keyword = '',
    Snippet = '﬌',
    Color = '',
    File = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
  },
})
