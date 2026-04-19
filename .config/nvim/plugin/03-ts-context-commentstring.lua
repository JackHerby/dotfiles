-- A Neovim plugin for setting the commentstring option based on the cursor location in the file.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("JoosepAlviste/nvim-ts-context-commentstring"), -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
})
