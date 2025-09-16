-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- Function to open the corresponding PDF for the current TeX file in Zathura
local function zathura_open_pdf()
  -- Get the full path of the current buffer
  local full_path = vim.fn.expand("%:p")

  -- Replace the .tex extension with .pdf at the end of the string
  local pdf_file = string.gsub(full_path, "%.tex$", ".pdf", 1)

  -- Basic check: If the path didn't change, it wasn't a .tex file
  if pdf_file == full_path then
    vim.notify("Error: Current file does not end with .tex", vim.log.levels.ERROR)
    return
  end

  -- Construct the command string, quoting the filename for safety
  local command = "zathura '" .. pdf_file .. "' &"

  -- Execute the command asynchronously in the background
  vim.fn.jobstart(command, { detach = true })
end

-- Create a user command :ZathuraOpenPdf that calls the Lua function
vim.api.nvim_create_user_command(
  "ZathuraOpenPdf", -- Command name
  zathura_open_pdf, -- Lua function to call
  {} -- Command options (none needed here)
)
