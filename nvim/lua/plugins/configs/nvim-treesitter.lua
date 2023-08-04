local M = {}

local treesitter = require('nvim-treesitter.configs')

function M.setup()
  treesitter.setup {
  ensure_installed = {
      "vim",
      "bash",
      "c",
      "cmake", 
      "cpp",
      "dockerfile",
      "html",
      "javascript",
      "json",
      "latex",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "rst",
      "toml",
      "typescript",
      "yaml"
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = false
  },
  autopairs = {
    enable = true,
  },
  matchup = {
    enable = true,
},
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
    }
  },
  textobjects = {
    move = {
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}
end

return M
