-- This plugin is the pure lua replacement for github/copilot.vim.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("zbirenbaum/copilot.lua"), -- https://github.com/zbirenbaum/copilot.lua
  githubUrl("copilotlsp-nvim/copilot-lsp"), -- https://github.com/copilotlsp-nvim/copilot-lsp
  githubUrl("fang2hou/blink-copilot"), -- https://github.com/fang2hou/blink-copilot
  githubUrl("CopilotC-Nvim/CopilotChat.nvim"), -- https://github.com/CopilotC-Nvim/CopilotChat.nvim
})

local nvimCreateAutocmd = require("utils.nvim-create-autocmd")
nvimCreateAutocmd("InsertEnter", {
  callback = function()
    vim.cmd.packadd("copilot.lua")
    vim.cmd.packadd("copilot-lsp")
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
      nes = { enabled = true },
    })
  end,
  once = true,
})

local keymap = require("utils.keymap")
keymap("<leader>cc", function() vim.cmd("CopilotChat") end, { desc = "Open [c]hat with optional input." }, { "n", "v" })
keymap("<leader>cm", function() vim.cmd("CopilotChatModels") end, { desc = "View/Select available [m]odels." })
keymap("<leader>cp", function() vim.cmd("CopilotChatPrompts") end, { desc = "View/Select [p]rompt templates." })
keymap("<leader>cr", function() vim.cmd("CopilotChatReset") end, { desc = "[R]eset chat window." })
keymap("<leader>cs", function() vim.cmd("CopilotChatStop") end, { desc = "[S]top current output." })
keymap("<leader>ct", function() vim.cmd("CopilotChatCommit") end, { desc = "Write commi[t] message." })
keymap("<leader>ct", function() vim.cmd("CopilotChatToggle") end, { desc = "Toggle [c]hat window." })
