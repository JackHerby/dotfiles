-- The nvim-treesitter plugin provides
-- 1. functions for installing, updating, and removing tree-sitter parsers;
-- 2. a collection of queries for enabling tree-sitter features built into Neovim for these languages;
-- 3. a staging ground for treesitter-based features considered for upstreaming to Neovim.

local githubUrl = require("utils.github-url")
vim.pack.add({
  { src = githubUrl("nvim-treesitter/nvim-treesitter"), version = "main" }, -- https://github.com/nvim-treesitter/nvim-treesitter
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
local function treesitter_try_attach(buf, language)
  -- Check if parser exists and load it.
  if not vim.treesitter.language.add(language) then return end
  -- Enables syntax highlighting and other treesitter features.
  vim.treesitter.start(buf, language)

  -- Check if treesitter indentation is available for this language, and if so enable it.
  -- In case there is no indent query, the indentexpr will fallback to the vim's built in one.
  local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil

  -- Enables treesitter based indentation.
  if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local available_parsers = require("nvim-treesitter").get_available()

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    local installed_parsers = require("nvim-treesitter").get_installed("parsers")

    if vim.tbl_contains(installed_parsers, language) then
      -- Enable the parser if it is installed.
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- If a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done.
      require("nvim-treesitter").install(language):await(function() treesitter_try_attach(buf, language) end)
    else
      -- Try to enable Treesitter features in case the parser exists but is not available from `nvim-treesitter`.
      treesitter_try_attach(buf, language)
    end
  end,
})
