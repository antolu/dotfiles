local M = {}

local telescope = require("telescope")
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local wk = require("which-key")

local function set_keymaps()
    wk.register({
        t = {
            name = "Telescope",
            b = { "<cmd>Telescope buffers<CR>", "search buffers" },
            f = { "<cmd>Telescope find_files<CR>", "search files" },
            g = { "<cmd>Telescope live_grep<CR>", "grep" },
            G = { "<cmd>Telescope grep_string<CR>", "grep word under cursor" },
            h = { "<cmd>Telescope help_tags<CR>", "search help" },
            r = { "<cmd>Telescope resume<CR>", "resume last search" },
            s = { "<cmd>Telescope session-lens search_session", "search session" }
        },
    }, {
        prefix = "<leader>",
    })
end

function M.setup()
    telescope.setup({
        defaults = {
            vimgrep_arguments = {
                "rg",
                "-L",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            prompt_prefix = "   ",
            selection_caret = "  ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            file_ignore_patterns = { "node_modules", "venv", ".venv" },
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            path_display = { "truncate" },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
            mappings = {
                i = {
                    ["<c-t>"] = trouble.open_with_trouble,
                    ["<c-f>"] = actions.preview_scrolling_down,
                    ["<c-b>"] = actions.preview_scrolling_up,
                    ["<c-u>"] = false,
                    ["<c-d>"] = false,
                },
                n = {
                    ["q"] = actions.close,
                    ["<c-t>"] = trouble.open_with_trouble,
                    ["<c-f>"] = actions.preview_scrolling_down,
                    ["<c-b>"] = actions.preview_scrolling_up,
                },
            },
        },
        pickers = {
            find_files = {
                follow = true,
            },
            buffers = {
                initial_mode = "normal",
                sort_lastused = true,
                sort_mru = true,
                theme = "dropdown",
                previewer = false,
                mappings = {
                    i = {
                        ["<c-d>"] = actions.delete_buffer,
                    },
                    n = {
                        ["dd"] = actions.delete_buffer,
                    },
                },
            },
            lsp_code_actions = {
                theme = "cursor",
            },
        },
    })
    set_keymaps()
end

return M
