local M = {}

local copilot = require('copilot')
local copilot_cmp = require('copilot_cmp')


function M.setup() 
    copilot.setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
  })
  copilot_cmp.setup({
    formatters = {
    insert_text = require("copilot_cmp.format").remove_existing
  },
  })
end

return M

