local M = {}

local barbar = require("bufferline")
local wk = require("which-key")

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
-- Close buffer
map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
-- Sort automatically by...
map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

local function set_keymaps(bufnr)
	wk.register({
		b = {
			name = "Bufferline",
			[","] = { "<Cmd>BufferPrevious<CR>", "Previous" },
			["."] = { "<Cmd>BufferNext<CR>", "Next" },
			["<"] = { "<Cmd>BufferMovePrevious<CR>", "Move to previous" },
			[">"] = { "<Cmd>BufferMoveNext", "Move to next" },
			["1"] = { "<Cmd>BufferGoto 1 <CR>", "Go to buffer 1" },
			["2"] = { "<Cmd>BufferGoto 2 <CR>", "Go to buffer 1" },
			["3"] = { "<Cmd>BufferGoto 3 <CR>", "Go to buffer 1" },
			["4"] = { "<Cmd>BufferGoto 4 <CR>", "Go to buffer 1" },
			["5"] = { "<Cmd>BufferGoto 5 <CR>", "Go to buffer 1" },
			["6"] = { "<Cmd>BufferGoto 6 <CR>", "Go to buffer 1" },
			["7"] = { "<Cmd>BufferGoto 7 <CR>", "Go to buffer 1" },
			["8"] = { "<Cmd>BufferGoto 8 <CR>", "Go to buffer 1" },
			["9"] = { "<Cmd>BufferGoto 9 <CR>", "Go to buffer 1" },
			["0"] = { "<Cmd>BufferLast <CR>", "Go to last buffer" },
			["p"] = { "<Cmd>BufferPin<CR>", "Pin buffer" },
			["c"] = { "<Cmd>BufferClose<CR>", "Close buffer" },
			s = {
				name = "Sort",
				["b"] = { "<Cmd>BufferOrderByBufferNumber<CR>", "Sort by buffer number" },
				["d"] = { "<Cmd>BufferOrderByDirectory<CR>", "Sort by directory" },
				["l"] = { "<Cmd>BufferOrderByLanguage<CR>", "Sort by language" },
				["w"] = { "<Cmd>BufferOrderByWindowNumber<CR>", "Sort by window number" },
			},
		},
		{
			prefix = "<leader>",
			buffer = bufnr,
		},
	})
end

function M.setup()
	barbar.setup({
		animation = true,
		auto_hide = true,
		tabpages = true,
		closble = true,
		clickable = true,
		diagnostics = {
			-- you can use a list
			{ enabled = true, icon = "ﬀ" }, -- ERROR
			{ enabled = false }, -- WARN
			{ enabled = false }, -- INFO
			{ enabled = true }, -- HINT
			-- OR `vim.diagnostic.severity`
			[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
			[vim.diagnostic.severity.WARN] = { enabled = false },
			[vim.diagnostic.severity.INFO] = { enabled = false },
			[vim.diagnostic.severity.HINT] = { enabled = true },
		},
		focus_on_close = "left",
		hide = { inactive = true },
		highlight_alternate = false,
		highlight_inactive_file_icons = false,
		highlight_visible = true,
		icons = true,
		icon_custom_colors = false,
		icon_separator_active = "▎",
		icon_separator_inactive = "▎",
		icon_close_tab = "",
		icon_close_tab_modified = "●",
		icon_pinned = "車",
		insert_at_end = false,
		insert_at_start = false,
		maximum_padding = 1,
		minimum_padding = 1,
		maximum_length = 30,
		semantic_letters = true,
		no_name_title = nil,
	})
	set_keymaps()
end

vim.api.nvim_create_autocmd("FileType", {
	callback = function(tbl)
		local set_offset = require("bufferline.api").set_offset

		local bufwinid
		local last_width
		local autocmd = vim.api.nvim_create_autocmd("WinScrolled", {
			callback = function()
				bufwinid = bufwinid or vim.fn.bufwinid(tbl.buf)

				local width = vim.api.nvim_win_get_width(bufwinid)
				if width ~= last_width then
					set_offset(width, "FileTree")
					last_width = width
				end
			end,
		})

		vim.api.nvim_create_autocmd("BufWipeout", {
			buffer = tbl.buf,
			callback = function()
				vim.api.nvim_del_autocmd(autocmd)
				set_offset(0)
			end,
			once = true,
		})
	end,
	pattern = "NvimTree", -- or any other filetree's `ft`
})

return M
