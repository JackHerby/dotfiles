-- A File Explorer For Neovim Written In Lua.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("nvim-tree/nvim-tree.lua"), -- https://github.com/nvim-tree/nvim-tree.lua
})

require("nvim-tree").setup({
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  disable_netrw = true,
  view = {
    width = function() return math.floor(vim.o.columns * 0.33) end,
    side = "right",
    number = true,
    cursorline = true,
  },
})

local keymap = require("utils.keymap")
keymap(
  "<leader>tf",
  function() vim.cmd("NvimTreeFindFile") end,
  { desc = "Move cursor to current [f]ile in Nvim Tree." }
)
keymap("<leader>tc", function() vim.cmd("NvimTreeCollapse") end, { desc = "[C]ollapse nvim-tree recursively." })
keymap("<leader>tg", function() vim.cmd("NvimTreeFindFileToggle") end, { desc = "Find file or to[g]gle Nvim Tree." })
keymap("<leader>tr", function() vim.cmd("NvimTreeRefresh") end, { desc = "[R]efresh Nvim Tree." })
keymap("<leader>ts", function() vim.cmd("NvimTreeFocus") end, { desc = "Nvim Tree focu[s]." })
keymap("<leader>tt", function() vim.cmd("NvimTreeToggle") end, { desc = "[T]oggle Nvim Tree." })
