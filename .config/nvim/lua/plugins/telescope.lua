-- https://github.com/nvim-telescope/telescope.nvim

---@module 'lazy'
---@type LazySpec
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function() return vim.fn.executable('make') == 1 end,
    },
    'nvim-telescope/telescope-node-modules.nvim',
    'nvim-telescope/telescope-project.nvim',
    'nvim-telescope/telescope-symbols.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
        path_display = { 'filename_first' },
        wrap_results = true,
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown({
            borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          }),
        },
      },
      pickers = {
        lsp_definitions = {
          show_line = false,
        },
        lsp_type_definitions = {
          show_line = false,
        },
        lsp_implementations = {
          show_line = false,
        },
        lsp_references = {
          show_line = false,
        },
      },
    })

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'node_modules')
    pcall(require('telescope').load_extension, 'project')
    pcall(require('telescope').load_extension, 'symbols')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require('telescope.builtin')
    local extensions = require('telescope').extensions

    local keymap = require('utils.keymap')
    keymap(
      '<leader>sc',
      function() builtin.live_grep({ type_filter = 'css' }) end,
      { desc = 'Search by grep in [c]ss files' }
    )
    keymap('<leader>sd', builtin.diagnostics, { desc = 'Search in [d]iagnostics' })
    keymap('<leader>sf', builtin.find_files, { desc = 'Search for [f]iles' })
    keymap(
      '<leader>sF',
      function() builtin.find_files({ default_text = vim.fn.expand('<cword>') }) end,
      { desc = 'Search [F]iles by word under cursor' }
    )
    keymap('<leader>sg', builtin.live_grep, { desc = 'Search by [g]rep' })
    keymap('<leader>sh', builtin.help_tags, { desc = 'Search in [h]elp' })
    keymap(
      '<leader>sH',
      function() builtin.help_tags({ default_text = vim.fn.expand('<cword>') }) end,
      { desc = 'Search [h]elp for the word under the cursor' }
    )
    keymap(
      '<leader>si',
      function() builtin.find_files({ hidden = true, no_ignore = true }) end,
      { desc = 'Search by grep including hidden and git [i]gnored files' }
    )
    keymap(
      '<leader>sj',
      function()
        builtin.live_grep({
          type_filter = 'js',
          additional_args = { '--type=ts' },
        })
      end,
      { desc = 'Search by grep in [J]avaScript files' }
    )
    keymap('<leader>sk', builtin.keymaps, { desc = 'Search [k]eymaps' })
    keymap(
      '<leader>sn',
      function() builtin.find_files({ cwd = vim.fn.stdpath('config') }) end,
      { desc = 'Search in [N]eovim files' }
    )
    keymap('<leader>sm', function() extensions.node_modules.list() end, { desc = 'Search in node [m]odules' })
    keymap('<leader>sp', function() extensions.project.project() end, { desc = 'Search in [p]rojects' })
    keymap('<leader>sr', builtin.resume, { desc = '[R]esume search' })
    keymap('<leader>ss', builtin.symbols, { desc = 'Search for [s]ymbols' })
    keymap('<leader>sw', builtin.grep_string, { desc = 'Search for current [w]ord' })
    keymap('<leader>s.', builtin.oldfiles, { desc = 'Search recent files ("." for repeat)' })
    keymap(
      '<leader>s/',
      function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        })
      end,
      { desc = 'Search [/] in open files' }
    )
    keymap('<leader><leader>', builtin.buffers, { desc = 'Search in opened buffers' })
    keymap('<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = 'Fuzzily search in current buffer' })
  end,
}
