local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
    {
        src = githubUrl("bluz71/vim-moonfly-colors"), -- https://github.com/bluz71/vim-moonfly-colors
        name = "moonfly",
    },
})

-- require("moonfly").setup({})
vim.cmd.colorscheme("moonfly")
