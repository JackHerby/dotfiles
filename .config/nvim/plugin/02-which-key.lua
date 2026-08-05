-- WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  githubUrl('folke/which-key.nvim'), -- https://github.com/folke/which-key.nvim
})

require('which-key').setup({
  -- Delay between pressing a key and opening which-key (milliseconds).
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },

  -- Document existing key chains.
  spec = {
    { '<leader>a', group = 'LSP [a]ctions' },
    { '<leader>d', group = '[D]ebug Adapter Protocol' },
    { '<leader>e', group = 'Pretty TS [E]rrors' },
    { '<leader>f', group = 'Conform [f]ormatting' },
    { '<leader>g', group = 'Vim Fugitive [g]it' },
    { '<leader>k', group = 'Random [k]eymaps' },
    { '<leader>m', group = '[M]ini' },
    { '<leader>o', group = '[O]pencode' },
    { '<leader>p', group = 'Neovim [p]ackage manager' },
    { '<leader>s', group = 'Fzf [s]earch' },
    { '<leader>t', group = 'Nvim [T]ree' },
    { '<leader>u', group = '[U]dotree' },
    { '<leader>y', group = '[Y]azi file manager' },
  },
})
