-- https://github.com/ibhagwan/fzf-lua
-- Fzf-lua aims to be as plug and play as possible with sane defaults.

---@module 'lazy'
---@type LazySpec
return {
  'ibhagwan/fzf-lua',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local fzf = require('fzf-lua')
    -- Register as the handler for vim.ui.select (replaces telescope-ui-select)
    fzf.register_ui_select()
    fzf.setup({
      keymap = {
        fzf = {
          true,
          -- Use <c-q> to select all items and add them to the quickfix list
          ['ctrl-q'] = 'select-all+accept',
        },
      },
    })

    local keymap = require('utils.keymap')
    keymap('<leader>sb', function() fzf.builtin() end, { desc = 'Search in [b]uiltin pickers.' })
    keymap(
      '<leader>sc',
      function()
        fzf.live_grep({ rg_opts = '--type=css --column --line-number --no-heading --color=always --smart-case' })
      end,
      { desc = 'Search by grep in [c]ss files' }
    )
    keymap('<leader>sd', function() fzf.diagnostics_workspace() end, { desc = 'Search in [d]iagnostics' })
    keymap('<leader>sf', function() fzf.files() end, { desc = 'Search for [f]iles' })
    keymap(
      '<leader>sF',
      function() fzf.files({ query = vim.fn.expand('<cword>') }) end,
      { desc = 'Search [F]iles by word under cursor' }
    )
    keymap('<leader>sg', function() fzf.live_grep() end, { desc = 'Search by [g]rep' })
    keymap('<leader>sh', function() fzf.helptags() end, { desc = 'Search in [h]elp' })
    keymap(
      '<leader>sH',
      function() fzf.helptags({ query = vim.fn.expand('<cword>') }) end,
      { desc = 'Search [h]elp for the word under the cursor' }
    )
    keymap(
      '<leader>si',
      function() fzf.files({ fd_opts = '--type f --hidden --no-ignore --follow' }) end,
      { desc = 'Search including hidden and git [i]gnored files' }
    )
    keymap(
      '<leader>sj',
      function()
        fzf.live_grep({
          rg_opts = '--type=js --type=ts --column --line-number --no-heading --color=always --smart-case',
        })
      end,
      { desc = 'Search by grep in [J]avaScript files' }
    )
    keymap('<leader>sk', function() fzf.keymaps() end, { desc = 'Search [k]eymaps' })
    keymap(
      '<leader>sn',
      function() fzf.files({ cwd = vim.fn.stdpath('config') }) end,
      { desc = 'Search in [N]eovim files' }
    )
    keymap('<leader>sr', function() fzf.resume() end, { desc = '[R]esume search' })
    keymap('<leader>sw', function() fzf.grep_cword() end, { desc = 'Search for current [w]ord' })
    keymap('<leader><leader>', function() fzf.buffers() end, { desc = 'Search in opened buffers' })
  end,
}
