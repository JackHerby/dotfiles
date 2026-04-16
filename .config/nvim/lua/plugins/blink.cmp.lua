-- A completion plugin with support for LSPs, cmdline, signature help, and snippets.

---@module 'lazy'
---@type LazySpec
return {
  'saghen/blink.cmp', -- https://github.com/Saghen/blink.cmp
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip', -- https://github.com/L3MON4D3/LuaSnip
      version = '2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then return end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
        },
      },
      opts = {},
    },
    'folke/lazydev.nvim', -- https://github.com/folke/lazydev.nvim
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
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
  },
}
