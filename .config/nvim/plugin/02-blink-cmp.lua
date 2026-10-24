-- A completion plugin with support for LSPs, cmdline, signature help, and snippets.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
    { src = githubUrl("saghen/blink.cmp"), version = vim.version.range("1.x") }, -- https://github.com/saghen/blink.cmp
    -- Dependencies.
    githubUrl("folke/lazydev.nvim"), -- https://github.com/folke/lazydev.nvim
})

require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})

require("blink.cmp").setup({
    appearance = { nerd_font_variant = "mono" },
    completion = { documentation = { auto_show = false }, menu = { auto_show = false } },
    -- See :h blink-cmp-config-fuzzy for more information.
    fuzzy = { implementation = "prefer_rust_with_warning" },
    keymap = {
        -- TODO: For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`.
        -- See :h blink-cmp-config-keymap for defining your own keymap.
        preset = "default",
    },
    -- Shows a signature help window while you type arguments for a function.
    signature = { enabled = true, trigger = { enabled = false } },
    sources = {
        default = { "lsp", "path", "snippets", "lazydev", "buffer" },
        providers = { lazydev = { module = "lazydev.integrations.blink", score_offset = 100 } },
    },
})
