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
keymap("<leader>ec", function() vim.cmd("NvimTreeCollapse") end, { desc = "[c]ollapse nvim-tree recursively" })
keymap("<leader>ee", function() vim.cmd("NvimTreeToggle") end, { desc = "[t]oggle Nvim Tree" })
keymap(
  "<leader>ef",
  function() vim.cmd("NvimTreeFindFile") end,
  { desc = "move cursor to current [f]ile in Nvim Tree" }
)
keymap("<leader>eg", function() vim.cmd("NvimTreeFindFileToggle") end, { desc = "find file or to[g]gle Nvim Tree" })
keymap("<leader>er", function() vim.cmd("NvimTreeRefresh") end, { desc = "[r]efresh Nvim Tree" })
keymap("<leader>es", function() vim.cmd("NvimTreeFocus") end, { desc = "Nvim Tree focu[s]" })
