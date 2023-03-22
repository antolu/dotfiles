local M = {}

local wk = require("which-key")
local nvim_tree = require("nvim-tree")

local function set_keymaps()
    wk.register({
        n = {
            name = "NvimTree",
            t = { "<Cmd>NvimTreeToggle<CR>", "Toggle NvimTree" },
            c = { "<Cmd>NvimTreeFindFile<CR>", "Show current file in NvimTree" },
        },
        prefix = "<leader>",
    })
end

function M.setup()
    nvim_tree.setup({
        view = {
            width = 40,
        },
        sort_by = "case_sensitive",
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
    })
    set_keymaps()
end

return M
