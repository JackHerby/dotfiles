-- Opencode integration for Neovim.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
    githubUrl("NickvanDyke/opencode.nvim"), -- https://github.com/NickvanDyke/opencode.nvim
})

---@type opencode.Opts
vim.g.opencode_opts = {
    events = {
        permissions = {
            enabled = false,
        },
    },
}

-- `opts.events.reload` sets this automatically; kept explicit for clarity.
vim.o.autoread = true

local keymap = require("utils.keymap")
keymap(
    "<leader>ca",
    function() require("opencode").ask("") end,
    { desc = "[A]sk Opencode" },
    { "n", "v", "x" }
)
keymap(
    "<leader>cc",
    function() require("opencode").ask("@this: ") end,
    { desc = "Opencode ask with [c]ontext" },
    { "n", "v", "x" }
)
keymap(
    "<leader>cs",
    function() require("opencode").select() end,
    { desc = "Execute Opencode [s]elected action" },
    { "n", "v", "x" }
)
