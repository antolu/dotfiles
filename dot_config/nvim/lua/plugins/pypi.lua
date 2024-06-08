return {
  {
    "nvim-cmp",
    dependencies = {
      "vrslev/cmp-pypi",
      dependencies = { "nvim-lua/plenary.nvim" },
      ft = "toml",
      -- event = "VeryLazy",
    },

    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "pypi",
        keyword_length = 4,
      })
    end,
  },
}
