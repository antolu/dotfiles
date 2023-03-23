local M = {}

local cmp_lsp = require("cmp_nvim_lsp")
local lsp_format = require("lsp-format")
local nvim_lsp = require("lspconfig")
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local navic = require("nvim-navic")
local wk = require("which-key")
require("code_action_menu")

local function set_commands()
    -- Commands.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.cmd("command! LspDeclaration lua vim.lsp.buf.declaration()")
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspOrganize lua lsp_organize_imports()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
    vim.cmd("command! LspWorkspaceList lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))")
    vim.cmd("command! LspWorkspaceAdd lua vim.lsp.buf.add_workspace_folder()")
    vim.cmd("command! LspWorkspaceRemove lua vim.lsp.buf.remove_workspace_folder()")
end

local function set_keymaps(bufnr)
    wk.register({
        g = {
            name = "LSP goto",
            d = { "<cmd>Telescope lsp_definitions<CR>", "definitions" },
            D = { "<cmd>LspTypeDef<CR>", "type definition" },
            L = { "<cmd>LspDeclaration<CR>", "declaration" },
            i = { "<cmd>Telescope lsp_implementations<CR>", "implementations" },
            r = { "<cmd>Telescope lsp_references<CR>", "references" },
        },
        c = {
            name = "LSP code changes",
            a = { "<cmd>CodeActionMenu<CR>", "code actions" },
            f = { "<cmd>Format<CR>", "format" },
            r = { "<cmd>LspRename<CR>", "rename variable" },
        },
    }, {
        prefix = "<leader>",
        buffer = bufnr,
    })
    wk.register({
        K = { "<cmd>LspHover<CR>", "LSP hover" },
        ["<C-S>"] = { "<cmd>LspSignatureHelp<CR>", "LSP signature help" },
    }, {
        buffer = bufnr,
    })
end

local function set_capabilities()
    -- Add capabilities for nvim-cmp
    local capabilities = cmp_lsp.default_capabilities()
    -- Add capabilities for nvim-ufo
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    M.capabilities = capabilities
end

function M.on_attach(client, bufnr)
    M.on_attach_no_symbols(client, bufnr)

    if vim.b.lsp_symbol_support_loaded then
        return
    end

    navic.attach(client, bufnr)
    vim.b.lsp_symbol_support_loaded = 1
    require("lsp-status").on_attach(client)
end

function M.on_attach_no_symbols(client, bufnr)
    lsp_format.on_attach(client)
    if vim.b.lsp_buffer_set_up then
        return
    end

    --Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    set_commands()
    set_keymaps(bufnr)

    vim.b.lsp_buffer_set_up = 1
end

function M.setup()
    set_capabilities()
    nvim_lsp.pylsp.setup({
        capabilities = M.capabilities,
        on_attach = M.on_attach,
        settings = {
            pylsp = {
                plugins = {
                    autopep8 = {
                        enabled = false,
                    },
                    black = {
                        enabled = true,
                        line_length = 79,
                    },
                    isort = {
                        enabled = true,
                        profile = "black",
                        line_length = 79,
                    },
                    flake8 = {
                        enabled = true,
                        ignore = { "E203", "E266", "E501", "W503", "F401", "F403" },
                        maxLineLength = 79,
                        maxComplexity = 18,
                        select = { "B", "C", "E", "F", "W", "T4", "B9" },
                    },
                    pylsp_mypy = {
                        enabled = true,
                        config_sub_paths = {},
                        overrides = { "--config-path=pyproject.toml" }
                    },
                    pydocstyle = {
                        enabled = true,
                        ignore = {
                            "D100",
                            "D104",
                            "D105",
                            "D107",
                            "D203",
                            "D213",
                            "D406",
                            "D407",
                            "D408",
                            "D409",
                            "D410",
                            "D411",
                        },
                        match = { "([A-Z][a-z0-9]+){2,}" },
                        match_dir = { "test" },
                    },
                    rope_autoimport = {
                        enabled = true,
                    },
                    rope_completion = {
                        enabled = true,
                    },
                    yapf = {
                        enabled = false,
                    },
                },
            },
        },
    })
    -- nvim_lsp.pyright.setup({
    --     capabilities = M.capabilities,
    --     on_attach = M.on_attach,
    --     settings = {
    --         pyright = {
    --                 disableOrganizeImports = true,
    --         },
    --         python = {
    --             analysis = {
    --                 autoSearchPaths = true,
    --                 useLibraryCodeForTypes = true,
    --                 typeCheckingMode = "off",
    --                 disableOrganizeImports = true,
    --             },
    --         },
    --     },
    -- })
    nvim_lsp.vimls.setup({
        capabilities = M.capabilities,
        on_attach = M.on_attach,
    })

    mason.setup()
    mason_lsp.setup()

    mason_lsp.setup_handlers({
        function(server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup({
                capabilities = M.capabilities,
                on_attach = M.on_attach,
            })
        end,
    })
end

return M
