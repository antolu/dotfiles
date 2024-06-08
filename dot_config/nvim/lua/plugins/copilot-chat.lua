return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
      { "<leader>Cc", ":CopilotChatToggle<CR>", desc = "Toggle Copilot Chat", mode = { "n", "v", "s" } },
      { "<leader>Cf", ":CopilotChatFix<CR>", desc = "Fix code with Copilot", mode = { "n", "v", "s" } },
      { "<leader>Cd", ":CopilotChatDocs<CR>", desc = "Open Docs Copilot", mode = { "n", "v", "s" } },
      { "<leader>Ct", ":CopilotChatTests<CR>", desc = "Generate Tests with Copilot", mode = { "n", "v", "s" } },
      { "<leader>Cr", ":CopilotChatReview<CR>", desc = "Review code with Copilot", mode = { "n", "v", "s" } },
      { "<leader>Ce", ":CopilotChatExplain<CR>", desc = "Explain code with Copilot", mode = { "n", "v", "s" } },
      { "<leader>Co", ":CopilotChatOptimize<CR>", desc = "Optimize code with Copilot", mode = { "n", "v", "s" } },
    },
  },
}
