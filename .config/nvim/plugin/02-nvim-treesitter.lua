-- The nvim-treesitter plugin provides
-- 1. Functions for installing, updating, and removing tree-sitter parsers;
-- 2. A collection of queries for enabling tree-sitter features built into Neovim for these languages;
-- 3. A staging ground for treesitter-based features considered for upstreaming to Neovim.

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  { src = githubUrl('nvim-treesitter/nvim-treesitter'), version = 'main' }, -- https://github.com/nvim-treesitter/nvim-treesitter
  githubUrl('nvim-treesitter/nvim-treesitter-context'), -- https://github.com/nvim-treesitter/nvim-treesitter-context
  githubUrl('nvim-treesitter/nvim-treesitter-textobjects'), -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
})

-- Ensure basic parser are installed.
local parsers = {
  'bash',
  'css',
  'dockerfile',
  'html',
  'javascript',
  'lua',
  'python',
  'rust',
  'typescript',
  'vimdoc',
  'vue',
  'yaml',
}
require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function treesitterTryAttach(buf, language)
  -- Check if parser exists and load it.
  if not vim.treesitter.language.add(language) then return end
  -- Enables syntax highlighting and other treesitter features.
  vim.treesitter.start(buf, language)

  -- Check if treesitter indentation is available for this language, and if so enable it.
  -- In case there is no indent query, the indentexpr will fallback to the vim's built in one.
  local hasIndentQuery = vim.treesitter.query.get(language, 'indents') ~= nil

  -- Enables treesitter based indentation.
  if hasIndentQuery then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local availableParsers = require('nvim-treesitter').get_available()

local nvimCreateAutocmd = require('utils.nvim-create-autocmd')
nvimCreateAutocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    local installedParsers = require('nvim-treesitter').get_installed('parsers')

    if vim.tbl_contains(installedParsers, language) then
      -- Enable the parser if it is installed.
      treesitterTryAttach(buf, language)
    elseif vim.tbl_contains(availableParsers, language) then
      -- If a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done.
      require('nvim-treesitter').install(language):await(function() treesitterTryAttach(buf, language) end)
    else
      -- Try to enable Treesitter features in case the parser exists but is not available from `nvim-treesitter`.
      treesitterTryAttach(buf, language)
    end
  end,
})

require('treesitter-context').setup({
  multiwindow = true,
  separator = '─',
})

local keymap = require('utils.keymap')
keymap(
  '[x',
  function() require('treesitter-context').go_to_context(vim.v.count1) end,
  { desc = 'Go to context', silent = true }
)

-- Disable entire built-in ftplugin mappings to avoid conflicts.
-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
vim.g.no_plugin_maps = true

require('nvim-treesitter-textobjects').setup({
  select = {
    lookahead = true,
  },
  move = {
    set_jumps = true,
  },
})

-- Keymaps
-- You can use the capture groups defined in `textobjects.scm`.
keymap(
  'af',
  function() require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects') end,
  { desc = 'Around function' },
  { 'x', 'o' }
)
keymap(
  'if',
  function() require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects') end,
  { desc = 'Inside function' },
  { 'x', 'o' }
)
keymap(
  'ac',
  function() require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects') end,
  { desc = 'Around class' },
  { 'x', 'o' }
)
keymap(
  'ic',
  function() require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects') end,
  { desc = 'Inside class' },
  { 'x', 'o' }
)
-- You can also use captures from other query groups like `locals.scm`.
keymap(
  'as',
  function() require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals') end,
  { desc = 'Around scope' },
  { 'x', 'o' }
)

-- Move
keymap(
  ']f',
  function() require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects') end,
  { desc = 'Next function start' },
  { 'n', 'x', 'o' }
)
keymap(
  ']]',
  function() require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects') end,
  { desc = 'Next class start' },
  { 'n', 'x', 'o' }
)
-- You can also pass a list to group multiple queries.
keymap(
  ']o',
  function()
    require('nvim-treesitter-textobjects.move').goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects')
  end,
  { desc = 'Next loop start' },
  { 'n', 'x', 'o' }
)
-- You can also use captures from other query groups like `locals.scm` or `folds.scm`.
keymap(
  ']s',
  function() require('nvim-treesitter-textobjects.move').goto_next_start('@local.scope', 'locals') end,
  { desc = 'Next scope start' },
  { 'n', 'x', 'o' }
)
keymap(
  ']z',
  function() require('nvim-treesitter-textobjects.move').goto_next_start('@fold', 'folds') end,
  { desc = 'Next fold start' },
  { 'n', 'x', 'o' }
)

keymap(
  ']F',
  function() require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects') end,
  { desc = 'Next function end' },
  { 'n', 'x', 'o' }
)
keymap(
  '][',
  function() require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects') end,
  { desc = 'Next class end' },
  { 'n', 'x', 'o' }
)

keymap(
  '[f',
  function() require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects') end,
  { desc = 'Previous function start' },
  { 'n', 'x', 'o' }
)
keymap(
  '[[',
  function() require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects') end,
  { desc = 'Previous class start' },
  { 'n', 'x', 'o' }
)

keymap(
  '[F',
  function() require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects') end,
  { desc = 'Previous function end' },
  { 'n', 'x', 'o' }
)
keymap(
  '[]',
  function() require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects') end,
  { desc = 'Previous class end' },
  { 'n', 'x', 'o' }
)

-- Go to either the start or the end, whichever is closer.
-- Use if you want more granular movements
keymap(
  ']n',
  function() require('nvim-treesitter-textobjects.move').goto_next('@conditional.outer', 'textobjects') end,
  { desc = 'Next conditional' },
  { 'n', 'x', 'o' }
)
keymap(
  '[n',
  function() require('nvim-treesitter-textobjects.move').goto_previous('@conditional.outer', 'textobjects') end,
  { desc = 'Previous conditional' },
  { 'n', 'x', 'o' }
)

local tsRepeatMove = require('nvim-treesitter-textobjects.repeatable_move')

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
keymap(';', tsRepeatMove.repeat_last_move_next, {}, { 'n', 'x', 'o' })
keymap(',', tsRepeatMove.repeat_last_move_previous, {}, { 'n', 'x', 'o' })

-- vim way: ; goes to the direction you were moving.
-- keymap(";", tsRepeatMove.repeat_last_move, {}, { "n", "x", "o" })
-- keymap(",", tsRepeatMove.repeat_last_move_opposite, {}, { "n", "x", "o" })

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
keymap('f', tsRepeatMove.builtin_f_expr, { expr = true }, { 'n', 'x', 'o' })
keymap('F', tsRepeatMove.builtin_F_expr, { expr = true }, { 'n', 'x', 'o' })
keymap('t', tsRepeatMove.builtin_t_expr, { expr = true }, { 'n', 'x', 'o' })
keymap('T', tsRepeatMove.builtin_T_expr, { expr = true }, { 'n', 'x', 'o' })
