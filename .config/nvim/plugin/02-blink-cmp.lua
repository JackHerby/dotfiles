-- A completion plugin with support for LSPs, cmdline, signature help, and snippets.

local github_url = require('utils.github_url')
vim.pack.add({
  github_url('rafamadriz/friendly-snippets'), -- https://github.com/rafamadriz/friendly-snippets
  { src = github_url('L3MON4D3/LuaSnip'), version = vim.version.range('2.x') }, -- https://github.com/L3MON4D3/LuaSnip
  github_url('folke/lazydev.nvim'), -- https://github.com/folke/lazydev.nvim
  { src = github_url('saghen/blink.cmp'), version = vim.version.range('1.x') }, -- https://github.com/Sagithub_urlen/blink.cmp
})

require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip').setup({})
require('lazydev').setup({
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})

require('blink.cmp').setup({
  keymap = {
    -- TODO: For an understanding of why the 'default' preset is recommended,
    -- you will need to read `:help ins-completion`.
    -- See :h blink-cmp-config-keymap for defining your own keymap.
    preset = 'default',
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
    providers = {
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
    },
  },
  snippets = { preset = 'luasnip' },
  -- See :h blink-cmp-config-fuzzy for more information.
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  -- Shows a signature help window while you type arguments for a function.
  signature = { enabled = true },
})
