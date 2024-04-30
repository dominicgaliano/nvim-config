require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
    disable = {},
  },

  ensure_installed = { "python",
  "javascript",
  "typescript",
  "c",
  "lua",
  "vim",
  "vimdoc",
  "query",
  "tsx",
  "json",
  "yaml",
  "css",
  "html",
  "markdown",
  "markdown_inline",
  "svelte",
  "go",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  autotag = {
    enable = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
