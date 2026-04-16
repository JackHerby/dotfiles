-- Nvim-lspconfig is a collection of LSP server configurations for the Nvim LSP client.

---@module 'lazy'
---@type LazySpec
return {
  -- :help lsp-vs-treesitter
  'neovim/nvim-lspconfig', -- https://github.com/neovim/nvim-lspconfig
  dependencies = {
    {
      'mason-org/mason.nvim', -- https://github.com/mason-org/mason.nvim
      ---@module 'mason.settings'
      ---@type MasonSettings
      ---@diagnostic disable-next-line: missing-fields
      opts = {},
    },
    {
      'mason-org/mason-lspconfig.nvim', -- https://github.com/mason-org/mason-lspconfig.nvim
    },
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim', -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    },
    {
      'j-hui/fidget.nvim', -- https://github.com/j-hui/fidget.nvim
      opts = {
        notification = {
          window = {
            avoid = { 'NvimTree' },
            border = 'single',
            winblend = 0,
          },
        },
      },
    },
  },
  config = function()
    -- This function gets run when an LSP attaches to a particular buffer.
    -- That is to say, every time a new file is opened that is associated with
    -- an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    -- function will be executed to configure the current buffer.
    local keymap = require('utils.keymap')
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local fzf = require('fzf-lua')
        keymap('<leader>an', vim.lsp.buf.rename, { desc = 're[n]ame symbol' })
        keymap('<leader>aa', vim.lsp.buf.code_action, { desc = 'goto code [a]ction' }, { 'n', 'x' })
        keymap('<leader>ar', function() fzf.lsp_references() end, { desc = 'goto [r]eferences' })
        keymap('<leader>ai', function() fzf.lsp_implementations() end, { desc = 'goto [i]mplementation' })
        keymap('<leader>ad', function() fzf.lsp_definitions() end, { desc = 'goto [d]efinition' })
        keymap('<leader>aD', vim.lsp.buf.declaration, { desc = 'goto [d]eclaration' })
        keymap('<leader>aO', function() fzf.lsp_document_symbols() end, { desc = 'open document symb[o]ls' })
        keymap('<leader>aW', function() fzf.lsp_live_workspace_symbols() end, { desc = 'open [w]orkspace symbols' })
        keymap('<leader>at', function() fzf.lsp_typedefs() end, { desc = 'goto [t]ype definition' })

        local function diagnostic_open_float()
          vim.diagnostic.open_float({
            scope = 'cursor',
            source = true,
            width = 128,
          })
        end
        keymap('<leader>af', diagnostic_open_float, { desc = 'open [f]loating window for diagnostics' })

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        -- See `:help CursorHold` for information about when this is executed.
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/documentHighlight', event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
            end,
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your code,
        -- if the language server you are using supports them.
        -- This may be unwanted, since they displace some of your code.
        if client and client:supports_method('textDocument/inlayHint', event.buf) then
          keymap(
            '<leader>ah',
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end,
            { desc = 'toggle inlay [h]ints' }
          )
        end
      end,
    })

    -- Enable the following language servers.
    local vue_language_server_path = vim.fn.expand('$MASON/packages')
      .. '/vue-language-server'
      .. '/node_modules/@vue/language-server'

    local servers = {
      bashls = {
        filetypes = { 'sh', 'zsh' },
      },
      cssls = {},
      emmet_language_server = {},
      eslint = {},
      html = {},
      hyprls = {},
      lemminx = {
        filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg', 'xlf', 'xliff', 'tmx' },
      },
      lua_ls = {},
      rust_analyzer = {},
      stylelint_lsp = {
        filetypes = { 'css', 'scss', 'less', 'vue' },
        settings = {
          stylelintplus = {
            autoFixOnFormat = true,
          },
        },
      },
      tailwindcss = {},
      vtsls = {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = vue_language_server_path,
                  languages = { 'vue' },
                  configNamespace = 'typescript',
                },
              },
            },
          },
        },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      },
      vue_ls = {},
    }

    ---@type MasonLspconfigSettings
    ---@diagnostic disable-next-line: missing-fields
    require('mason-lspconfig').setup({
      automatic_enable = vim.tbl_keys(servers or {}),
    })

    -- Ensure the servers and tools above are installed.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'beautysh',
      'eslint',
      'js-debug-adapter',
      'markdownlint',
      'prettier',
      'prettierd',
      'shellcheck',
      'stylelint-lsp',
      'stylua',
    })

    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end

    vim.api.nvim_create_user_command(
      'StylelintFixAll',
      function() vim.lsp.buf.format({ name = 'stylelint_lsp', async = false }) end,
      { desc = 'Fix stylelint issues via LSP formatting.' }
    )

    keymap('<leader>S', function() vim.cmd('StylelintFix') end, { desc = 'style[l]int fix all' })
  end,
}
