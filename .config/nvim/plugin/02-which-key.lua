-- WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("folke/which-key.nvim"), -- https://github.com/folke/which-key.nvim
})

require("which-key").setup({
  -- Delay between pressing a key and opening which-key (milliseconds).
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },

  -- Document existing key chains.
  spec = {
    { "<leader>a", group = "LSP [a]ctions" },
    { "<leader>b", group = "Mini [b]ufremove" },
    { "<leader>d", group = "[D]AP" },
    { "<leader>f", group = "Conform [f]ormat on save enable/disable" },
    { "<leader>g", group = "Fugitive [g]it" },
    { "<leader>h", group = "[H]arpoon" },
    { "<leader>l", group = "[l]ocation list" },
    { "<leader>o", group = "[O]pencode" },
    { "<leader>p", group = "vim.[p]ack" },
    { "<leader>q", group = "[q]uickfix list" },
    { "<leader>s", group = "fzf [s]earch" },
    { "<leader>t", group = "Pretty [T]S errors" },
    { "<leader>u", group = "[U]ndo Tree." },
  },
})
