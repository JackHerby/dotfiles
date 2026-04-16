-- https://github.com/stevearc/conform.nvim
-- Lightweight yet powerful formatter plugin for Neovim.

---@module 'lazy'
---@type LazySpec
return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>F',
      function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
      mode = '',
      desc = '[F]ormat buffer',
    },
    { '<leader>fe', '<cmd>FormatEnable<CR>', mode = 'n', desc = '[E]nable autoformatting' },
    { '<leader>fd', '<cmd>FormatDisable<CR>', mode = 'n', desc = '[D]isable autoformatting' },
    { '<leader>fb', '<cmd>FormatDisable!<CR>', mode = 'n', desc = '[D]isable autoformatting in current buffer' },
    { '<leader>fi', '<cmd>FormatInfo<CR>', mode = 'n', desc = 'Autoformat [i]nfo' },
    { '<leader>fc', '<cmd>ConformInfo<CR>', mode = 'n', desc = '[C]onform info' },
  },
  config = function(_, opts)
    require('conform').setup(opts)

    vim.g.disable_autoformat = true

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable formatting on save',
      bang = true,
    })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable formatting on save',
    })

    vim.api.nvim_create_user_command('FormatInfo', function()
      if vim.b.disable_autoformat then
        print('Formatting is disabled for this buffer')
      else
        print('Formatting is enabled for this buffer')
      end

      if vim.g.disable_autoformat then
        print('Format on save is disabled')
      else
        print('Format on save is enabled')
      end
    end, { desc = 'Print autoformat-on-save info' })
  end,
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      bash = { 'shellcheck' },
      css = { 'prettier', 'prettierd', stop_after_first = true },
      html = { 'prettier', 'prettierd', stop_after_first = true },
      javascript = { 'prettier', 'prettierd', stop_after_first = true },
      javascriptreact = { 'prettier', 'prettierd', stop_after_first = true },
      json = { 'prettier', 'prettierd', stop_after_first = true },
      lua = { 'stylua' },
      markdown = { 'markdownlint' },
      sh = { 'shellcheck' },
      typescript = { 'prettier', 'prettierd', stop_after_first = true },
      typescriptreact = { 'prettier', 'prettierd', stop_after_first = true },
      vue = { 'prettier', 'prettierd', stop_after_first = true },
      yaml = { 'prettier', 'prettierd', stop_after_first = true },
      zsh = { 'beautysh' },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    -- Customize formatters
    formatters = {
      -- shfmt = {
      --   append_args = { '-i', '2' },
      -- },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
