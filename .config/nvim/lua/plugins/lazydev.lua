-- Lazydev.nvim is a plugin that properly configures LuaLS for editing your Neovim config by lazily updating your workspace libraries.

---@module 'lazy'
---@type LazySpec
return {
  'folke/lazydev.nvim', -- https://github.com/folke/lazydev.nvim
  ft = 'lua',
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` word is found.
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  },
}
