-- Debug Adapter Protocol client implementation for Neovim.
-- TODO: I've set this up with a lot of vibe coding, I need to check if it works and why if so.

local githubUrl = require('utils.github-url')
local packAdd = require('utils.pack-add')
packAdd({
  githubUrl('mfussenegger/nvim-dap'), -- https://github.com/mfussenegger/nvim-dap
})

local dap = require('dap')

-- Adapter: pwa-node (Node.js).
dap.adapters['pwa-node'] = {
  executable = {
    args = { vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
    command = 'node',
  },
  host = '127.0.0.1',
  port = '${port}',
  type = 'server',
}

-- Adapter: pwa-chrome (browser).
dap.adapters['pwa-chrome'] = {
  executable = {
    args = { vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
    command = 'node',
  },
  host = '127.0.0.1',
  port = '${port}',
  type = 'server',
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
local jsFiletypes = {
  'javascript',
  'typescript',
  'javascriptreact',
  'typescriptreact',
  'vue',
}
for _, lang in ipairs(jsFiletypes) do
  dap.configurations[lang] = {
    {
      cwd = '${workspaceFolder}',
      name = 'Launch file',
      program = '${file}',
      request = 'launch',
      sourceMaps = true,
      type = 'pwa-node',
    },
    {
      cwd = '${workspaceFolder}',
      name = 'Attach to Node (pick process)',
      processId = require('dap.utils').pick_process,
      request = 'attach',
      sourceMaps = true,
      type = 'pwa-node',
    },
    {
      cwd = '${workspaceFolder}',
      name = 'Attach to port 9229',
      port = 9229,
      request = 'attach',
      sourceMaps = true,
      type = 'pwa-node',
    },
    {
      cwd = '${workspaceFolder}',
      name = 'Nuxt: dev server',
      request = 'launch',
      runtimeArgs = { 'nuxi', 'dev' },
      runtimeExecutable = 'npx',
      sourceMaps = true,
      type = 'pwa-node',
    },
    {
      name = 'Chrome: localhost:3000',
      request = 'launch',
      sourceMaps = true,
      type = 'pwa-chrome',
      url = 'http://localhost:3000',
      webRoot = '${workspaceFolder}',
    },
  }
end

-- Breakpoint signs.
vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
local icons = vim.g.have_nerd_font
    and {
      Breakpoint = '',
      BreakpointCondition = '',
      BreakpointRejected = '',
      LogPoint = '',
      Stopped = '',
    }
  or {
    Breakpoint = '●',
    BreakpointCondition = '⊜',
    BreakpointRejected = '⊘',
    LogPoint = '◆',
    Stopped = '⭔',
  }
for type, icon in pairs(icons) do
  local tp = 'Dap' .. type
  local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

-- REPL auto-completion.
local nvimCreateAutocmd = require('utils.nvim-create-autocmd')
nvimCreateAutocmd('FileType', {
  callback = function() require('dap.ext.autocompl').attach() end,
  pattern = 'dap-repl',
})

-- Keymaps.
local keymap = require('utils.keymap')
keymap('<leader>db', dap.toggle_breakpoint, { desc = 'Toggle [b]reakpoint' })
keymap(
  '<leader>dB',
  function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
  { desc = 'Conditional [B]reakpoint' }
)
keymap('<leader>dc', dap.continue, { desc = '[C]ontinue / start' })
keymap('<leader>df', function()
  local w = require('dap.ui.widgets')
  w.centered_float(w.frames)
end, { desc = 'Float [f]rames' })
keymap('<leader>dh', function() require('dap.ui.widgets').hover() end, { desc = '[H]over value' }, { 'n', 'v' })
keymap('<leader>di', dap.step_into, { desc = 'Step [i]nto' })
keymap('<leader>dl', dap.run_last, { desc = 'Run [l]ast' })
keymap(
  '<leader>dm',
  function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
  { desc = 'Log point [m]essage' }
)
keymap('<leader>do', dap.step_over, { desc = 'Step [o]ver' })
keymap('<leader>dp', function() require('dap.ui.widgets').preview() end, { desc = '[P]review value' }, { 'n', 'v' })
keymap('<leader>dr', dap.repl.toggle, { desc = 'Toggle [R]EPL' })
keymap('<leader>ds', function()
  local w = require('dap.ui.widgets')
  w.centered_float(w.scopes)
end, { desc = 'Float [s]copes' })
keymap('<leader>dt', dap.step_out, { desc = 'Step out' })
keymap('<leader>dx', dap.terminate, { desc = 'Terminate session' })
