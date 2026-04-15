-- https://github.com/folke/which-key.nvim

---@module 'lazy'
---@type LazySpec
return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  ---@module 'which-key'
  ---@type wk.Opts
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },

    -- Document existing key chains
    spec = {
      { '<leader>a', group = 'LSP [a]ctions' },
      { '<leader>b', group = 'Mini [b]ufremove' },
      { '<leader>d', group = '[D]ap' },
      { '<leader>f', group = 'Conform [f]ormat on save enable/disable' },
      { '<leader>g', group = 'Fugitive [g]it' },
      { '<leader>h', group = '[H]arpoon' },
      { '<leader>l', group = '[L]ocation list' },
      { '<leader>q', group = '[Q]uickfix list' },
      { '<leader>s', group = 'Fzf [s]earch' },
      { '<leader>t', group = 'Pretty [T]S errors' },
      { '<leader>u', group = '[U]ndoo tree' },
    },
  },
}
