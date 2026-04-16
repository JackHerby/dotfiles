-- https://github.com/mfussenegger/nvim-dap
-- Debug Adapter Protocol client implementation for Neovim.

---@module 'lazy'
---@type LazySpec
return {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mason-org/mason.nvim',
    'mxsdev/nvim-dap-vscode-js',
    {
      'microsoft/vscode-js-debug',
      version = '1.x',
      build = 'npm i && npm run compile vsDebugServerBundle && mv dist out',
    },
  },
  keys = {
    { '<Leader>dB', function() require('dap').set_breakpoint() end, desc = 'Set [b]reakpoint.' },
    { '<Leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle [b]reakpoint.' },
    { '<leader>dc', function() require('dap').continue() end, desc = '[C]ontinue.' },
    {
      '<leader>df',
      function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
      end,
      desc = 'Centered float [f]rames.',
    },
    { '<leader>dh', function() require('dap.ui.widgets').hover() end, desc = '[H]over.' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Step [i]nto.' },
    { '<leader>dl', function() require('dapui').toggle() end, desc = 'See [l]ast session result.' },
    {
      '<Leader>dm',
      function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
      desc = 'Set breakpoint with [m]essage.',
    },
    { '<leader>do', function() require('dap').step_over() end, desc = 'Step [o]ver.' },
    { '<leader>dp', function() require('dap.ui.widgets').preview() end, desc = '[P]review.' },
    {
      '<leader>ds',
      function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
      end,
      desc = 'Centered float [s]copes.',
    },
    { '<leader>dt', function() require('dap').step_out() end, desc = 'Step ou[t].' },
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    -- Dap UI setup.
    -- For more information, see |:help nvim-dap-ui|.
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.25 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          position = 'left',
          size = 60,
        },
        {
          elements = {
            { id = 'repl', size = 0.5 },
            { id = 'console', size = 0.5 },
          },
          position = 'bottom',
          size = 15,
        },
      },
    })

    -- Change breakpoint icons.
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and {
          Breakpoint = '',
          BreakpointCondition = '',
          BreakpointRejected = '',
          LogPoint = '',
          Stopped = '',
        }
      or {
        Breakpoint = '●',
        BreakpointCondition = '⊜',
        BreakpointRejected = '⊘',
        LogPoint = '◆',
        Stopped = '⭔',
      }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open({ reset = true }) end
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-vscode-js').setup({
      debugger_path = vim.fn.stdpath('data') .. '/lazy/vscode-js-debug',
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    })

    for _, language in ipairs({ 'typescript', 'javascript', 'vue', 'typescriptreact', 'javascriptreact' }) do
      dap.configurations[language] = {
        -- Debug single nodejs files.
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
        -- Debug nodejs processes (make sure to add --inspect when you run the process).
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
        -- Debug web applications (client side).
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch & Debug Chrome',
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({
                prompt = 'Enter URL: ',
                default = 'http://localhost:3000',
              }, function(url)
                if url == nil or url == '' then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = '${workspaceFolder}',
          skipFiles = { '<node_internals>/**/*.js' },
          protocol = 'inspector',
          sourceMaps = true,
          userDataDir = false,
        },
        -- Divider for the launch.json derived configs.
        {
          name = '----- ↓ launch.json configs ↓ -----',
          type = '',
          request = 'launch',
        },
      }
    end
  end,
}
