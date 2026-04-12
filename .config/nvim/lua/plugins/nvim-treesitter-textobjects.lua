-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects

---@module 'lazy'
---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
    vim.g.no_plugin_maps = true

    -- Or, disable per filetype (add as you like)
    -- vim.g.no_python_maps = true
    -- vim.g.no_ruby_maps = true
    -- vim.g.no_rust_maps = true
    -- vim.g.no_go_maps = true
  end,
  config = function()
    -- put your config here
    require('nvim-treesitter-textobjects').setup({
      move = {
        -- whether to set jumps in the jumplist
        set_jumps = true,
      },
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = false,
    })

    local keymap = require('utils.keymap')
    -- Move key maps
    local ts_move = require('nvim-treesitter-textobjects.move')
    keymap(
      ']m',
      function() ts_move.goto_next_start('@function.outer', 'textobjects') end,
      { desc = 'Next function start' },
      { 'n', 'x', 'o' }
    )
    keymap(
      ']]',
      function() ts_move.goto_next_start('@class.outer', 'textobjects') end,
      { desc = 'Next class start' },
      { 'n', 'x', 'o' }
    )
    -- You can also pass a list to group multiple queries.
    keymap(
      ']o',
      function() ts_move.goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects') end,
      { desc = 'Next loop' },
      { 'n', 'x', 'o' }
    )
    -- You can also use captures from other query groups like `locals.scm` or `folds.scm`
    keymap(
      ']s',
      function() ts_move.goto_next_start('@local.scope', 'locals') end,
      { desc = 'Next scope start' },
      { 'n', 'x', 'o' }
    )
    keymap(
      ']z',
      function() ts_move.goto_next_start('@fold', 'folds') end,
      { desc = 'Next fold start' },
      { 'n', 'x', 'o' }
    )
    keymap(
      ']M',
      function() ts_move.goto_next_end('@function.outer', 'textobjects') end,
      { desc = 'Next function end' },
      { 'n', 'x', 'o' }
    )
    keymap(
      '][',
      function() ts_move.goto_next_end('@class.outer', 'textobjects') end,
      { desc = 'Next class end' },
      { 'n', 'x', 'o' }
    )
    keymap(
      '[m',
      function() ts_move.goto_previous_start('@function.outer', 'textobjects') end,
      { desc = 'Prev function start' },
      { 'n', 'x', 'o' }
    )
    keymap(
      '[[',
      function() ts_move.goto_previous_start('@class.outer', 'textobjects') end,
      { desc = 'Prev class start' },
      { 'n', 'x', 'o' }
    )
    keymap(
      '[M',
      function() ts_move.goto_previous_end('@function.outer', 'textobjects') end,
      { desc = 'Prev function end' },
      { 'n', 'x', 'o' }
    )
    keymap(
      '[]',
      function() ts_move.goto_previous_end('@class.outer', 'textobjects') end,
      { desc = 'Prev class end' },
      { 'n', 'x', 'o' }
    )
    -- Go to either the start or the end, whichever is closer.
    -- Use if you want more granular movements
    keymap(
      ']i',
      function() ts_move.goto_next('@conditional.outer', 'textobjects') end,
      { desc = 'Next conditional' },
      { 'n', 'x', 'o' }
    )
    keymap(
      '[i',
      function() ts_move.goto_previous('@conditional.outer', 'textobjects') end,
      { desc = 'Prev conditional' },
      { 'n', 'x', 'o' }
    )

    -- Select key maps
    -- You can use the capture groups defined in `textobjects.scm`
    local ts_select = require('nvim-treesitter-textobjects.select')
    keymap(
      'af',
      function() ts_select.select_textobject('@function.outer', 'textobjects') end,
      { desc = 'Select outer function' },
      { 'x', 'o' }
    )
    keymap(
      'if',
      function() ts_select.select_textobject('@function.inner', 'textobjects') end,
      { desc = 'Select inner function' },
      { 'x', 'o' }
    )
    keymap(
      'ac',
      function() ts_select.select_textobject('@class.outer', 'textobjects') end,
      { desc = 'Select outer class' },
      { 'x', 'o' }
    )
    keymap(
      'ic',
      function() ts_select.select_textobject('@class.inner', 'textobjects') end,
      { desc = 'Select inner class' },
      { 'x', 'o' }
    )

    -- You can also use captures from other query groups like `locals.scm`
    keymap(
      'as',
      function() ts_select.select_textobject('@local.scope', 'locals') end,
      { desc = 'Select local scope' },
      { 'x', 'o' }
    )

    -- Swap textobjects key maps
    local ts_swap = require('nvim-treesitter-textobjects.swap')
    keymap(
      '<leader>p',
      function() ts_swap.swap_next('@parameter.inner') end,
      { desc = 'Swap next [p]arameter (inner)' },
      'n'
    )
    keymap(
      '<leader>P',
      function() ts_swap.swap_next('@parameter.outer') end,
      { desc = 'Swap next [p]arameter (outer)' },
      'n'
    )

    -- Repeat movement key maps
    local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    keymap(';', ts_repeat_move.repeat_last_move_next, { desc = 'Repeat last move (next)' }, { 'n', 'x', 'o' })
    keymap(',', ts_repeat_move.repeat_last_move_previous, { desc = 'Repeat last move (prev)' }, { 'n', 'x', 'o' })

    -- vim way: ; goes to the direction you were moving.
    keymap(';', ts_repeat_move.repeat_last_move, nil, { 'n', 'x', 'o' })
    keymap(',', ts_repeat_move.repeat_last_move_opposite, nil, { 'n', 'x', 'o' })

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    keymap('f', ts_repeat_move.builtin_f_expr, { expr = true, desc = 'Repeatable f' }, { 'n', 'x', 'o' })
    keymap('F', ts_repeat_move.builtin_F_expr, { expr = true, desc = 'Repeatable F' }, { 'n', 'x', 'o' })
    keymap('t', ts_repeat_move.builtin_t_expr, { expr = true, desc = 'Repeatable t' }, { 'n', 'x', 'o' })
    keymap('T', ts_repeat_move.builtin_T_expr, { expr = true, desc = 'Repeatable T' }, { 'n', 'x', 'o' })

    -- This repeats the last query with always previous direction and to the start of the range.
    keymap(
      '<home>',
      function() ts_repeat_move.repeat_last_move({ forward = false, start = true }) end,
      nil,
      { 'n', 'x', 'o' }
    )

    -- This repeats the last query with always next direction and to the end of the range.
    keymap(
      '<end>',
      function() ts_repeat_move.repeat_last_move({ forward = true, start = false }) end,
      nil,
      { 'n', 'x', 'o' }
    )
  end,
}
