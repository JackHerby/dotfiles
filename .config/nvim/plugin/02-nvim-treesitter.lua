-- The nvim-treesitter plugin provides
-- 1. Functions for installing, updating, and removing tree-sitter parsers;
-- 2. A collection of queries for enabling tree-sitter features built into Neovim for these languages;
-- 3. A staging ground for treesitter-based features considered for upstreaming to Neovim.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  { src = githubUrl("nvim-treesitter/nvim-treesitter"), version = "main" }, -- https://github.com/nvim-treesitter/nvim-treesitter
  githubUrl("nvim-treesitter/nvim-treesitter-context"),
})

-- Ensure basic parser are installed.
local parsers = {
  "bash",
  "css",
  "dockerfile",
  "html",
  "javascript",
  "lua",
  "rust",
  "typescript",
  "vimdoc",
  "vue",
  "yaml",
}
require("nvim-treesitter").install(parsers)

---@param buf integer
---@param language string
local function treesitterTryAttach(buf, language)
  -- Check if parser exists and load it.
  if not vim.treesitter.language.add(language) then return end
  -- Enables syntax highlighting and other treesitter features.
  vim.treesitter.start(buf, language)

  -- Check if treesitter indentation is available for this language, and if so enable it.
  -- In case there is no indent query, the indentexpr will fallback to the vim's built in one.
  local hasIndentQuery = vim.treesitter.query.get(language, "indents") ~= nil

  -- Enables treesitter based indentation.
  if hasIndentQuery then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local availableParsers = require("nvim-treesitter").get_available()

local nvimCreateAutocmd = require("utils.nvim-create-autocmd")
nvimCreateAutocmd("FileType", {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    local installedParsers = require("nvim-treesitter").get_installed("parsers")

    if vim.tbl_contains(installedParsers, language) then
      -- Enable the parser if it is installed.
      treesitterTryAttach(buf, language)
    elseif vim.tbl_contains(availableParsers, language) then
      -- If a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done.
      require("nvim-treesitter").install(language):await(function() treesitterTryAttach(buf, language) end)
    else
      -- Try to enable Treesitter features in case the parser exists but is not available from `nvim-treesitter`.
      treesitterTryAttach(buf, language)
    end
  end,
})

require("treesitter-context").setup({
  multiwindow = true,
  separator = "─",
})

local keymap = require("utils.keymap")
keymap("[c", function() require("treesitter-context").go_to_context(vim.v.count1) end, { silent = true })
