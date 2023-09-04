local M = {}

local neo_tree = require('neo-tree')
local wk = require('which-key')

function set_keymaps()
    wk.register({
        n = {
            name = 'NeoTree',
            f = { "<Cmd>Neotree reveal filesystem left<CR>", "Show files" },
            F = { "<Cmd>Neotree toggle filesystem left<CR>", "Toggle files" },
            b = { "<Cmd>Neotree reveal buffers right<CR>", "Show buffers" },
            B = { "<Cmd>Neotree toggle buffers right<CR>", "Toggle buffers" },
            g = { "<Cmd>Neotree show focus git_status float<CR>", "Show git" },
            n = { "<Cmd>Neotree show focus float filesystem<CR>", "Show files floating" }
        },
    }, {
        prefix = '<leader>',
    })
end

function M.setup()
    set_keymaps()

    neo_tree.setup({
        window = {
            width = 32,
        }
    })
end

return M
