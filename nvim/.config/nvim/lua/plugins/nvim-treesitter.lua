require("nvim-treesitter.configs").setup {
  autopairs = {
    enable = true
  },
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 2000,
  },
  ensure_installed = {
    "javascript",
    "bash",
    "graphql",
    "regex",
    "python",
    "erlang",
    "elixir",
    "comment",
    "jsdoc",
    "yaml",
    "rust",
    "css",
    "tsx",
    "html",
    "dockerfile",
    "lua",
    "typescript",
    "toml",
    "json",
  },
  highlight = {
    enable = true,
    disable = {},
  },
  refactor = {
    highlight_definitions = { enable = true },
    navigation = {
      enable = true,
    },
  },
}
