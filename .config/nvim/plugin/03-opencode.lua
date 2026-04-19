-- Opencode integration for Neovim.

local githubUrl = require("utils.github-url")
vim.pack.add({
  githubUrl("NickvanDyke/opencode.nvim"), -- https://github.com/NickvanDyke/opencode.nvim
})

---@type opencode.Opts
vim.g.opencode_opts = {
  server = {
    start = false,
    stop = false,
    toggle = false,
  },
}

-- Required for `opts.events.reload`.
vim.o.autoread = true

local keymap = require("utils.keymap")
keymap(
  "<C-a>",
  function() require("opencode").command("session.half.page.up") end,
  { desc = "half page up" },
  { "n", "x" }
)
keymap(
  "<C-x>",
  function() require("opencode").command("session.half.page.down") end,
  { desc = "half page down" },
  { "n", "x" }
)
keymap("+", "<C-a>", { desc = "increment", noremap = true })
keymap("-", "<C-x>", { desc = "decrement", noremap = true })
keymap(
  "<leader>oa",
  function() require("opencode").ask("", { submit = true }) end,
  { desc = "[a]sk Opencode" },
  { "n", "v", "x" }
)
keymap(
  "<leader>oc",
  function() require("opencode").ask("@this: ", { submit = true }) end,
  { desc = "Opencode ask with [c]ontext" },
  { "n", "v", "x" }
)
keymap(
  "<leader>ol",
  function() return require("opencode").operator("@this ") .. "_" end,
  { desc = "add [l]ine to Opencode", expr = true }
)
keymap(
  "<leader>or",
  function() return require("opencode").operator("@this ") end,
  { desc = "add [r]ange to Opencode", expr = true },
  { "n", "x" }
)
keymap(
  "<leader>os",
  function() require("opencode").select() end,
  { desc = "execute Opencode [s]elected action" },
  { "n", "v", "x" }
)
