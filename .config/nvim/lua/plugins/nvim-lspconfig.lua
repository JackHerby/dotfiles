-- https://github.com/neovim/nvim-lspconfig

---@module 'lazy'
---@type LazySpec
return {
  -- :help lsp-vs-treesitter
  'neovim/nvim-lspconfig',
  dependencies = {
    { -- https://github.com/mason-org/mason.nvim
      'mason-org/mason.nvim',
      ---@module 'mason.settings'
      ---@type MasonSettings
      ---@diagnostic disable-next-line: missing-fields
      opts = {},
    },
    { -- https://github.com/mason-org/mason-lspconfig.nvim
      'mason-org/mason-lspconfig.nvim',
    },
    { -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    { -- https://github.com/j-hui/fidget.nvim
      'j-hui/fidget.nvim',
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
    -- function will be executed to configure the current buffer
    local keymap = require('utils.keymap')
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local telescope_builtin = require('telescope.builtin')
        keymap('<leader>an', vim.lsp.buf.rename, { desc = 'Re[n]ame symbol' })
        keymap('<leader>aa', vim.lsp.buf.code_action, { desc = 'Goto code [a]ction' }, { 'n', 'x' })
        keymap('<leader>ar', telescope_builtin.lsp_references, { desc = 'Goto [r]eferences' })
        keymap('<leader>ai', telescope_builtin.lsp_implementations, { desc = 'Goto [i]mplementation' })
        keymap('<leader>ad', telescope_builtin.lsp_definitions, { desc = 'Goto [d]efinition' })
        keymap('<leader>aD', vim.lsp.buf.declaration, { desc = 'Goto [d]eclaration' })
        keymap('<leader>aO', telescope_builtin.lsp_document_symbols, { desc = 'Open document symb[o]ls' })
        keymap('<leader>aW', telescope_builtin.lsp_dynamic_workspace_symbols, { desc = 'Open [w]orkspace symbols' })
        keymap('<leader>at', telescope_builtin.lsp_type_definitions, { desc = 'Goto [t]ype definition' })

        local function diagnostic_open_float()
          vim.diagnostic.open_float({
            scope = 'cursor',
            source = true,
            width = 128,
          })
        end
        keymap('<leader>af', diagnostic_open_float, { desc = 'Open [f]loating window for diagnostics' })

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        -- See `:help CursorHold` for information about when this is executed
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

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        -- This may be unwanted, since they displace some of your code
        if client and client:supports_method('textDocument/inlayHint', event.buf) then
          keymap(
            '<leader>ah',
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end,
            { desc = 'Toggle inlay [h]ints' }
          )
        end
      end,
    })

    -- Enable the following language servers
    local vue_language_server_path = vim.fn.expand('$MASON/packages')
      .. '/vue-language-server'
      .. '/node_modules/@vue/language-server'

    local servers = {
      bashls = {
        filetypes = { 'sh', 'zsh' },
      },
      cssls = {},
      emmet_language_server = {},
      html = {},
      hyprls = {},
      lemminx = {
        filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg', 'xlf', 'xliff', 'tmx' },
      },
      -- Special Lua Config, as recommended by neovim help docs
      lua_ls = {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
              path ~= vim.fn.stdpath('config')
              and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
              path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = {
              checkThirdParty = false,
              -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
              --  See https://github.com/neovim/nvim-lspconfig/issues/3189
              library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                '${3rd}/luv/library',
                '${3rd}/busted/library',
              }),
            },
          })
        end,
        settings = {
          Lua = {},
        },
      },
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

    -- Ensure the servers and tools above are installed
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
      { desc = 'Fix stylelint issues via LSP formatting' }
    )

    -- Key maps for lsp commands
    keymap('<leader>aI', function() vim.cmd('LspInfo') end, { desc = 'Lsp[I]nfo' })
    keymap('<leader>aR', function() vim.cmd('LspRestart') end, { desc = 'Lsp[R]estart' })
    keymap('<leader>aS', function() vim.cmd('LspStart') end, { desc = 'Lsp[S]tart' })
    keymap('<leader>aT', function() vim.cmd('LspStop') end, { desc = 'LspS[t]op' })
    keymap('<leader>S', function() vim.cmd('StylelintFix') end, { desc = 'Style[l]int fix all' })
  end,
}
