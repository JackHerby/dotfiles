-- An asynchronous linter plugin for Neovim (>= 0.9.5) complementary to the built-in Language Server Protocol support.

local githubUrl = require("utils.github-url")
vim.pack.add({
  githubUrl("mfussenegger/nvim-lint"), -- https://github.com/mfussenegger/nvim-lint
})

local lint = require("lint")
lint.linters_by_ft = {
  bash = { "shellcheck" },
  markdown = { "markdownlint" },
  javascript = { "eslint" },
  sh = { "shellcheck" },
  typescript = { "eslint" },
  vue = { "eslint" },
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  callback = function()
    -- Only run the linter in buffers that you can modify in order to avoid superfluous noise,
    -- notably within the handy LSP pop-ups that describes the hovered symbol using Markdown.
    if vim.opt_local.modifiable:get() then lint.try_lint() end
  end,
  group = vim.api.nvim_create_augroup("lint", { clear = true }),
})
