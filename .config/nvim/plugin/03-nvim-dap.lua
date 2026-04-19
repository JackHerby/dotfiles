-- Debug Adapter Protocol client implementation for Neovim.
-- TODO: I've set this up with a lot of vibe coding, I need to check if it works and why if so.

local githubUrl = require('utils.github-url')
vim.pack.add({
  githubUrl('mfussenegger/nvim-dap'), -- https://github.com/mfussenegger/nvim-dap
})

local dap = require('dap')

-- Adapter: pwa-node (Node.js).
dap.adapters['pwa-node'] = {
  type = 'server',
  host = '127.0.0.1',
  port = '${port}',
  executable = {
    command = 'node',
    args = {
      vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
      '${port}',
    },
  },
}

-- Adapter: pwa-chrome (browser).
dap.adapters['pwa-chrome'] = {
  type = 'server',
  host = '127.0.0.1',
  port = '${port}',
  executable = {
    command = 'node',
    args = {
      vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
      '${port}',
    },
  },
}

-- Alias: "node" -> "pwa-node" (for launch.json compat).
dap.adapters['node'] = function(cb, config)
  if config.type == 'node' then
    config = vim.deepcopy(config)
    config.type = 'pwa-node'
  end
  cb(dap.adapters['pwa-node']) ---@diagnostic disable-line: param-type-mismatch
end

-- Configurations.
local js_filetypes = {
  'javascript',
  'typescript',
  'javascriptreact',
  'typescriptreact',
  'vue',
}
for _, lang in ipairs(js_filetypes) do
  dap.configurations[lang] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach to Node (pick process)',
      processId = require('dap.utils').pick_process,
      cwd = '${workspaceFolder}',
      sourceMaps = true,
    },
    {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach to port 9229',
      port = 9229,
      cwd = '${workspaceFolder}',
      sourceMaps = true,
    },
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Nuxt: dev server',
      runtimeExecutable = 'npx',
      runtimeArgs = { 'nuxi', 'dev' },
      cwd = '${workspaceFolder}',
      sourceMaps = true,
    },
    {
      type = 'pwa-chrome',
      request = 'launch',
      name = 'Chrome: localhost:3000',
      url = 'http://localhost:3000',
      webRoot = '${workspaceFolder}',
      sourceMaps = true,
    },
  }
end

-- Breakpoint signs.
vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
local icons = vim.g.have_nerd_font
    and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
  or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
for type, icon in pairs(icons) do
  local tp = 'Dap' .. type
  local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

-- REPL auto-completion.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dap-repl',
  callback = function() require('dap.ext.autocompl').attach() end,
})

-- Keymaps.
local keymap = require('utils.keymap')
keymap('<leader>dc', dap.continue, { desc = '[c]ontinue / start' })
keymap('<leader>db', dap.toggle_breakpoint, { desc = 'toggle [b]reakpoint' })
keymap(
  '<leader>dB',
  function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
  { desc = 'conditional [B]reakpoint' }
)
keymap(
  '<leader>dm',
  function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
  { desc = 'log point [m]essage' }
)
keymap('<leader>di', dap.step_into, { desc = 'step [i]nto' })
keymap('<leader>do', dap.step_over, { desc = 'step [o]ver' })
keymap('<leader>dt', dap.step_out, { desc = 'step ou[t]' })
keymap('<leader>dr', dap.repl.toggle, { desc = 'toggle [R]EPL' })
keymap('<leader>dh', function() require('dap.ui.widgets').hover() end, { desc = '[h]over value' }, { 'n', 'v' })
keymap('<leader>dp', function() require('dap.ui.widgets').preview() end, { desc = '[p]review value' }, { 'n', 'v' })
keymap('<leader>ds', function()
  local w = require('dap.ui.widgets')
  w.centered_float(w.scopes)
end, { desc = 'float [s]copes' })
keymap('<leader>df', function()
  local w = require('dap.ui.widgets')
  w.centered_float(w.frames)
end, { desc = 'float [f]rames' })
keymap('<leader>dl', dap.run_last, { desc = 'run [l]ast' })
keymap('<leader>dx', dap.terminate, { desc = 'terminate session' })
