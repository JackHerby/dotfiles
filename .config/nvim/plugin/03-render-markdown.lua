-- Plugin to improve viewing Markdown files in Neovim.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("MeanderingProgrammer/render-markdown.nvim"), -- https://github.com/MeanderingProgrammer/render-markdown.nvim
})
