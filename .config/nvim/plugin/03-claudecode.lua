local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  githubUrl('coder/claudecode.nvim'), -- https://github.com/coder/claudecode.nvim
})

require('claudecode').setup({
  ---@diagnostic disable-next-line missing-fields
  terminal = {
    provider = 'none',
  },
})

local keymap = require('utils.keymap')
keymap('<leader>ca', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Claude Code [a]ccept diff' })
keymap('<leader>cb', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Claude Code add [b]uffer' })
keymap('<leader>cd', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = 'Claude Code [d]eny diff' })
keymap('<leader>cm', '<cmd>ClaudeCodeSelectModel<cr>', { desc = 'Claude Code select [m]odel' })
keymap('<leader>cs', '<cmd>ClaudeCodeSend<cr>', { desc = 'Claude Code [s]end selection' }, { 'v' })
