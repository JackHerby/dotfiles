-- A Neovim plugin that enhances TypeScript errors by formatting them into readable, markdown-formatted.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("youyoumu/pretty-ts-errors.nvim"), -- https://github.com/youyoumu/pretty-ts-errors.nvim
})

require("pretty-ts-errors").setup({
  auto_open = false,
})

-- Add ts-plugin as a source.
---@diagnostic disable-next-line: duplicate-set-field
require("pretty-ts-errors.utils").is_ts_source = function(source)
  return vim.tbl_contains({
    "tsserver",
    "ts",
    "typescript",
    "deno-ts",
    "ts-plugin",
  }, source)
end

-- Add ts-plugin as a source.
local keymap = require("utils.keymap")
keymap(
  "<leader>te",
  function() require("pretty-ts-errors").show_formatted_error() end,
  { desc = "show TypeScript [e]rror" }
)
keymap(
  "<leader>ta",
  function() require("pretty-ts-errors").open_all_errors() end,
  { desc = "show [a]ll TypeScript errors" }
)
keymap(
  "<leader>tt",
  function() require("pretty-ts-errors").toggle_auto_open() end,
  { desc = "[t]oggle TypeScript error auto-display" }
)
