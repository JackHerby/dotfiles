-- Nvim orgmode is a clone of Emacs Orgmode for Neovim 0.12.0+.
-- It aims to be a feature-complete implementation of Orgmode features in Neovim.

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  githubUrl('nvim-orgmode/orgmode') -- https://github.com/nvim-orgmode/orgmode
})

-- Setup orgmode
require('orgmode').setup({
  org_agenda_files = '~/orgfiles/**/*',
  org_default_notes_file = '~/orgfiles/refile.org',
})

-- Experimental LSP support
vim.lsp.enable('org')
