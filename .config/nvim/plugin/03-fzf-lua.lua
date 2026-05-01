-- Fzf-lua aims to be as plug and play as possible with sane defaults.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
  githubUrl("ibhagwan/fzf-lua"), -- https://github.com/ibhagwan/fzf-lua
})

local fzf = require("fzf-lua")
fzf.register_ui_select()
fzf.setup({
  fzf_colors = true,
  keymap = {
    fzf = {
      true,
      -- Use <c-q> to select all items and add them to the quickfix list.
      ["ctrl-q"] = "select-all+accept",
    },
  },
  winopts = {
    border = "single",
    ---@diagnostic disable-next-line: missing-fields
    preview = {
      border = "single",
    },
  },
})

local keymap = require("utils.keymap")
keymap("<leader>sb", function() fzf.buffers() end, { desc = "search in opened [b]uffers" })
keymap(
  "<leader>sc",
  function() fzf.live_grep({ rg_opts = "--type=css --column --line-number --no-heading --color=always --smart-case" }) end,
  { desc = "search by grep in [c]ss files" }
)
keymap("<leader>sd", function() fzf.diagnostics_workspace() end, { desc = "search in [d]iagnostics" })
keymap("<leader>sf", function() fzf.files() end, { desc = "search for [f]iles" })
keymap(
  "<leader>sF",
  function() fzf.files({ query = vim.fn.expand("<cword>") }) end,
  { desc = "search [F]iles by word under cursor" }
)
keymap("<leader>sg", function() fzf.live_grep() end, { desc = "search by [g]rep" })
keymap("<leader>sh", function() fzf.helptags() end, { desc = "search in [h]elp" })
keymap(
  "<leader>sH",
  function() fzf.helptags({ query = vim.fn.expand("<cword>") }) end,
  { desc = "search [h]elp for the word under the cursor" }
)
keymap(
  "<leader>si",
  function() fzf.files({ fd_opts = "--type f --hidden --no-ignore --follow" }) end,
  { desc = "search including hidden and git [i]gnored files" }
)
keymap(
  "<leader>sj",
  function()
    fzf.live_grep({
      rg_opts = "--type=js --type=ts --column --line-number --no-heading --color=always --smart-case",
    })
  end,
  { desc = "search by grep in [J]avaScript files" }
)
keymap("<leader>sk", function() fzf.keymaps() end, { desc = "search [k]eymaps" })
keymap(
  "<leader>sn",
  function() fzf.files({ cwd = vim.fn.stdpath("config") }) end,
  { desc = "search in [N]eovim files" }
)
keymap("<leader>sp", function() fzf.builtin() end, { desc = "search in builtin [p]ickers" })
keymap("<leader>sr", function() fzf.resume() end, { desc = "[r]esume search" })
keymap("<leader>sw", function() fzf.grep_cword() end, { desc = "search for current [w]ord" })
