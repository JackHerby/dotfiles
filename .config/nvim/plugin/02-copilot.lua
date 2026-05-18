-- This plugin is the pure lua replacement for github/copilot.vim.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("zbirenbaum/copilot.lua"), -- https://github.com/zbirenbaum/copilot.lua
  githubUrl("fang2hou/blink-copilot"), -- https://github.com/fang2hou/blink-copilot
  githubUrl("CopilotC-Nvim/CopilotChat.nvim"), -- https://github.com/CopilotC-Nvim/CopilotChat.nvim
})

local nvimCreateAutocmd = require("utils.nvim-create-autocmd")
nvimCreateAutocmd("InsertEnter", {
  callback = function()
    vim.cmd.packadd("copilot.lua")
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
  once = true,
})

-- Auto-command to customize chat buffer behavior
nvimCreateAutocmd("BufEnter", {
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
  pattern = "copilot-chat",
})

local keymap = require("utils.keymap")
keymap("<leader>cc", function() vim.cmd("CopilotChat") end, { desc = "Open [c]hat with optional input." }, { "n", "v" })
keymap("<leader>cm", function() vim.cmd("CopilotChatModels") end, { desc = "View/Select available [m]odels." })
keymap("<leader>cp", function() vim.cmd("CopilotChatPrompts") end, { desc = "View/Select [p]rompt templates." })
keymap("<leader>cr", function() vim.cmd("CopilotChatReset") end, { desc = "[R]eset chat window." })
keymap("<leader>cs", function() vim.cmd("CopilotChatStop") end, { desc = "[S]top current output." })
keymap("<leader>ct", function() vim.cmd("CopilotChatCommit") end, { desc = "Write commi[t] message." })
keymap("<leader>ct", function() vim.cmd("CopilotChatToggle") end, { desc = "Toggle [c]hat window." })
