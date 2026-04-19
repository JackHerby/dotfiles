-- Todo-comments is a lua plugin for Neovim >= 0.8.0 to highlight and search for todo comments like TODO, HACK, BUG in your code base.

local githubUrl = require("utils.github-url")
vim.pack.add({
  githubUrl("folke/todo-comments.nvim"), -- https://github.com/folke/todo-comments.nvim
})

require("todo-comments").setup({ signs = false })
