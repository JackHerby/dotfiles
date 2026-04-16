-- Blazing fast indentation style detection for Neovim written in Lua.

---@module 'lazy'
---@type LazySpec
return {
  -- Detect tabstop and shiftwidth automatically.
  'NMAC427/guess-indent.nvim', -- https://github.com/NMAC427/guess-indent.nvim
  opts = {},
}
