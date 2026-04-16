-- https://github.com/folke/which-key.nvim
-- WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.

---@module 'lazy'
---@type LazySpec
return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'.
  ---@module 'which-key'
  ---@type wk.Opts
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    -- Delay between pressing a key and opening which-key (milliseconds).
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },

    -- Document existing key chains.
    spec = {
      { '<leader>a', group = 'LSP [a]ctions.' },
      { '<leader>b', group = 'Mini [b]ufremove.' },
      { '<leader>d', group = '[D]ebug adapter protocol.' },
      { '<leader>e', group = 'Nvim tr[e]e keymaps.' },
      { '<leader>f', group = 'Conform [f]ormat on save enable/disable.' },
      { '<leader>g', group = 'Fugitive [g]it.' },
      { '<leader>h', group = '[H]arpoon file picker.' },
      { '<leader>l', group = '[L]ocation list keymaps.' },
      { '<leader>o', group = '[O]pencode keymaps.' },
      { '<leader>q', group = '[Q]uickfix list keymaps.' },
      { '<leader>s', group = 'Fzf [s]earch.' },
      { '<leader>t', group = 'Pretty [T]S errors.' },
      { '<leader>u', group = '[U]ndoo tree.' },
    },
  },
}
