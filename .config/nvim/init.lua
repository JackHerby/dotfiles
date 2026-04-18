-- :Tutor
-- :help
-- https://learnxinyminutes.com/docs/lua/
-- https://neovim.io/doc/user/lua-guide.html

-- Set <space> as the leader key.
-- See `:help mapleader`.
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used).
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed.
vim.g.have_nerd_font = true

-- disable netrw at the very start of your init.lua.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- See `:help vim.opt`.
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:help option-list`.

-- Make line numbers default.
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line.
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`.
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

-- Enable break indent.
vim.opt.breakindent = true

-- Save undo history.
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default.
vim.opt.signcolumn = 'yes'

-- Decrease update time.
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time.
-- Displays which-key popup sooner.
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`.
-- Commented out since setting is used in ident blankie plugin.
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on.
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.guicursor = ''
vim.opt.colorcolumn = '120'

-- Tab settings.
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- Pressing tab will insert spaces according to the tabstop and shiftwidth settings.
vim.opt.expandtab = true
vim.opt.autoindent = true
-- Specifies the number of spaces to use for a tab character when editing a buffer.
vim.bo.softtabstop = 2

-- Optionally enable 24-bit colour.
vim.opt.termguicolors = true

-- Set rounded borders for all floating windows (Neovim 0.11+).
vim.o.winborder = 'single'

-- Spelling options.
vim.opt.spell = true
vim.opt.spelllang = { 'en_us', 'pl' }

-- Neovide/GUI settings.
if vim.g.neovide then
  -- font
  vim.o.guifont = '0xProto Nerd Font Mono:h12'

  -- padding
  vim.g.neovide_padding_top = 2
  vim.g.neovide_padding_bottom = 2
  vim.g.neovide_padding_right = 2
  vim.g.neovide_padding_left = 2

  -- opacity
  vim.g.neovide_opacity = 1
  vim.g.neovide_normal_opacity = 0.95

  -- animations
  vim.g.neovide_position_animation_length = 0.1
  vim.g.neovide_scroll_animation_length = 0.15

  -- progress bar
  vim.g.neovide_progress_bar_enabled = true
  vim.g.neovide_progress_bar_height = 5.0
  vim.g.neovide_progress_bar_animation_speed = 200.0
  vim.g.neovide_progress_bar_hide_delay = 0.2

  -- theme
  vim.g.neovide_theme = 'dark'

  -- cursor
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_short_animation_length = 0.01
  vim.g.neovide_cursor_trail_size = 0.3
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.opt.guicursor =
    'n-v-c-i-ci-ve-r-cr-o:block,a:blinkwait800-blinkoff500-blinkon350-Cursor/lCursor,sm:block-blinkwait275-blinkoff250-blinkon275'
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_cursor_vfx_mode = 'torpedo'

  vim.env.TERM = 'xterm-256color'
end

-- Enable experimental ui2.
pcall(function() require('vim._core.ui2').enable() end)

-- Basic keymaps.
-- See `:help vim.keymap.set()`.
local keymap = require('utils.keymap')

-- Set highlight on search, but clear on pressing <Esc> in normal mode.
-- See `:help hlsearch`.
keymap('<Esc>', function() vim.cmd('nohlsearch') end, { desc = 'clear highligth search' })

-- Diagnostic Config & Keymaps.
-- See :help vim.diagnostic.Opts.
vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer.
  virtual_text = true, -- Text shows up at the end of the line.
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines.
})

-- Diagnostic list.
keymap('<leader>ll', vim.diagnostic.setloclist, { desc = 'open diagnostic [L]ocation list' })

-- Location list keymaps.
keymap('<leader>lo', function() vim.cmd('lopen') end, { desc = '[o]pen Location list' })
keymap('<leader>lc', function() vim.cmd('lclose') end, { desc = '[c]lose Location list' })
keymap('<leader>ln', function() vim.cmd('lnext') end, { desc = '[n]ext location item' })
keymap('<leader>lp', function() vim.cmd('lprevious') end, { desc = '[p]revious location item' })
keymap('<leader>lf', function() vim.cmd('lfirst') end, { desc = '[f]irst location item' })
keymap('<leader>la', function() vim.cmd('llast') end, { desc = 'l[a]st location item' })

-- Quickfix list keymaps.
keymap('<leader>qo', function() vim.cmd('copen') end, { desc = '[o]pen Quickfix list' })
keymap('<leader>qc', function() vim.cmd('cclose') end, { desc = '[c]lose Quickfix list' })
keymap('<leader>qn', function() vim.cmd('cnext') end, { desc = '[n]ext quickfix item' })
keymap('<leader>qp', function() vim.cmd('cprevious') end, { desc = '[p]revious quickfix item' })
keymap('<leader>qf', function() vim.cmd('cfirst') end, { desc = '[f]irst quickfix item' })
keymap('<leader>qa', function() vim.cmd('clast') end, { desc = 'l[a]st quickfix item' })

-- Terminal mode.
keymap('<Esc><Esc>', '<C-\\><C-n>', { desc = 'exit terminal mode' }, 't')

-- Open terminal mode window in bottom split.
local function open_term()
  vim.cmd.new()
  vim.cmd.term()
  vim.api.nvim_win_set_height(0, 20)
  vim.cmd('startinsert')
end
keymap('<leader>T', open_term, { desc = 'open [t]erminal in bottom split' })

-- TIP: Disable arrow keys in normal mode.
-- Utilize arrows to resize windows in normal mode.
keymap('<left>', function() vim.cmd('vertical resize -1') end, { desc = 'resize window left' })
keymap('<right>', function() vim.cmd('vertical resize +1') end, { desc = 'resize window right' })
keymap('<up>', function() vim.cmd('resize +1') end, { desc = 'resize window up' })
keymap('<down>', function() vim.cmd('resize -1') end, { desc = 'resize window down' })

-- Keybinds to make split navigation easier.
keymap('<C-h>', '<C-w><C-h>', { desc = 'move focus to the left window' })
keymap('<C-l>', '<C-w><C-l>', { desc = 'move focus to the right window' })
keymap('<C-j>', '<C-w><C-j>', { desc = 'move focus to the lower window' })
keymap('<C-k>', '<C-w><C-k>', { desc = 'move focus to the upper window' })

-- Move select.
-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes.
keymap('<C-M-h>', '<C-w>H', { desc = 'move window to the left' })
keymap('<C-M-l>', '<C-w>L', { desc = 'move window to the right' })
keymap('<C-M-j>', '<C-w>J', { desc = 'move window to the lower' })
keymap('<C-M-k>', '<C-w>K', { desc = 'move window to the upper' })

-- Change all occurances of the word under the cursor.
keymap('<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[r]ename all occurances' })

-- Open URL under cursor.
keymap('<leader>U', function()
  local url = vim.fn.expand('<cWORD>')
  if url:match('^https?://') then
    vim.fn.jobstart({ 'xdg-open', url }, { detach = true })
  else
    vim.notify('No valid URL found under cursor', vim.log.levels.WARN)
  end
end, { desc = 'Open [U]RL under the cursor' })

-- JavaScript/Typescript quality of life mappings.
keymap('<C-,>', '()', nil, 'i')
keymap('<C-.>', '=>', nil, 'i')
keymap('<C-/>', '->', nil, 'i')
keymap("<C-'>", '() => ', nil, 'i')

-- Trigger lint command providerd by eslint language server.
keymap('<leader>E', function() vim.cmd('LspEslintFixAll') end, { desc = '[E]SLint fix all' })

-- Basic autocommands.
--  See `:help lua-guide-autocommands`.

-- Highlight when yanking (copying) text.
--  Try it with `yap` in normal mode.
--  See `:help vim.highlight.on_yank()`.
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  desc = 'Highlight when yanking text.',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
})

-- Terminal mode customization.
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.opt.spell = false
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.cmd('setlocal bufhidden=wipe')
  end,
  desc = 'Customize terminal mode.',
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function() vim.opt_local.spell = false end,
  desc = 'Disable spellcheck in quickfix/location list.',
  group = vim.api.nvim_create_augroup('custom-qf-loclist', { clear = true }),
  pattern = { 'qf', 'nvim-pack', 'checkhealth' },
})

-- Must be defined before the very first vim.pack.add() call.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(event)
    local name, kind = event.data.spec.name, event.data.kind
    local pack_dir = vim.fn.stdpath('data') .. '/site/pack/core/opt/'

    if name == 'LuaSnip' and (kind == 'instal' or kind == 'update') then
      if vim.fn.has('win32') == 0 and vim.fn.executable('make') == 1 then
        vim.fn.system({ 'make', 'install_jsregexp', '-C', pack_dir .. 'LuaSnip' })
      end
    end

    if name == 'nvim-treesitter' and kind == 'update' then
      if not event.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
  desc = 'Hooks for plugins with build steps.',
})
