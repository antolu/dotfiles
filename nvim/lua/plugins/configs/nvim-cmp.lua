local M = {}

local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

function M.setup()
    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            -- ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete({
                reason = cmp.ContextReason.Auto,
            }), {"i", "c"}),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                select = true,
                behavior = cmp.ConfirmBehavior.Replace,
            }),
            ["<Tab>"] = vim.schedule_wrap(function(fallback)
                if cmp.visible() and has_words_before() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end),
        }),
        sources = cmp.config.sources({
            { name = "copilot", group_index = 2 },
            {
                name = 'nvim_lsp',
            },
            { name = 'luasnip' },
        }, {
            { name = 'nvim_lua' },
        }, {
            {
                name = 'buffer',
            },
            { name = 'path' },
        }),
        formatting = {
            format = lspkind.cmp_format({
                menu = {
                    copilot = '[Copilot]',
                    buffer = '[Buffer]',
                    luasnip = '[LuaSnip]',
                    nvim_lsp = '[LSP]',
                    nvim_lua = '[Lua]',
                    path = '[Path]',
                },
                format = lspkind.cmp_format({
                    mode = "symbol",
                    max_width = 50,
                    symbol_map = { Copilot = "" }
                })
            }),
        },
        sorting = {
            priority_weight = 2,
            comparators = {
                require("copilot_cmp.comparators").prioritize,

                -- Below is the default comparitor list and order for nvim-cmp
                cmp.config.compare.offset,
                -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                cmp.config.compare.exact,
                cmp.config.compare.score,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
    })
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'buffer' },
        }),
    })
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' },
        }, {
            { name = 'cmdline' },
        }),
    })
end

return M
