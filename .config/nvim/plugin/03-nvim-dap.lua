-- Debug Adapter Protocol client implementation for Neovim.
-- TODO: I've set this up with a lot of vibe coding, I need to check if it works and why if so.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
    githubUrl("mfussenegger/nvim-dap"), -- https://github.com/mfussenegger/nvim-dap
})

local dap = require("dap")

-- Adapters: js-debug serves both Node.js (pwa-node) and the browser (pwa-chrome).
-- The aliases let a VS Code launch.json with `"type": "node"` / `"chrome"` work unchanged:
-- js-debug itself only accepts the `pwa-*` names, so the type is rewritten before the session starts.
local jsDebugTypes = { ["pwa-chrome"] = "chrome", ["pwa-node"] = "node" }
for type, alias in pairs(jsDebugTypes) do
    local adapter = {
        executable = {
            args = {
                vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
                "${port}",
                -- js-debug defaults to `localhost`, which can bind ::1 while we connect via IPv4.
                "127.0.0.1",
            },
            command = "node",
        },
        host = "127.0.0.1",
        port = "${port}",
        type = "server",
    }
    dap.adapters[type] = adapter
    dap.adapters[alias] = vim.tbl_extend("force", adapter, {
        enrich_config = function(config, on_config)
            config = vim.deepcopy(config)
            config.type = type
            on_config(config)
        end,
    })
end

-- Configurations.
local js_filetypes = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "vue",
}
-- These are generic, host-only setups. Anything project-specific (Docker, path mappings, custom URLs)
-- belongs in the project's `.vscode/launch.json`, which nvim-dap picks up from the cwd automatically.
local skipFiles = { "<node_internals>/**", "**/node_modules/**" }
for _, lang in ipairs(js_filetypes) do
    dap.configurations[lang] = {
        {
            cwd = "${workspaceFolder}",
            name = "Node: launch current file",
            program = "${file}",
            request = "launch",
            skipFiles = skipFiles,
            type = "pwa-node",
        },
        {
            cwd = "${workspaceFolder}",
            name = "Node: launch npm script",
            request = "launch",
            runtimeArgs = function() return { "run", vim.fn.input("npm script: ", "dev") } end,
            runtimeExecutable = "npm",
            skipFiles = skipFiles,
            type = "pwa-node",
        },
        {
            cwd = "${workspaceFolder}",
            name = "Node: attach to process",
            processId = function() return require("dap.utils").pick_process({ filter = "node" }) end,
            request = "attach",
            skipFiles = skipFiles,
            type = "pwa-node",
        },
        {
            address = "127.0.0.1",
            cwd = "${workspaceFolder}",
            name = "Node: attach to port",
            port = function() return tonumber(vim.fn.input("Inspector port: ", "9229")) end,
            request = "attach",
            skipFiles = skipFiles,
            type = "pwa-node",
        },
        {
            -- Server side (Nitro, SSR). js-debug follows the child process that `nuxt dev` forks.
            cwd = "${workspaceFolder}",
            name = "Nuxt: dev server",
            request = "launch",
            runtimeArgs = { "nuxt", "dev" },
            runtimeExecutable = "npx",
            skipFiles = skipFiles,
            type = "pwa-node",
        },
        {
            -- Client side of a Vue (Vite, :5173) or Nuxt (:3000) app; the dev server must already be running.
            name = "Browser: launch Chrome",
            request = "launch",
            type = "pwa-chrome",
            url = function() return vim.fn.input("URL: ", "http://localhost:3000") end,
            webRoot = "${workspaceFolder}",
        },
    }
end

-- Breakpoint signs.
vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
local icons = vim.g.have_nerd_font
        and {
            Breakpoint = "",
            BreakpointCondition = "",
            BreakpointRejected = "",
            LogPoint = "",
            Stopped = "",
        }
    or {
        Breakpoint = "●",
        BreakpointCondition = "⊜",
        BreakpointRejected = "⊘",
        LogPoint = "◆",
        Stopped = "⭔",
    }
for type, icon in pairs(icons) do
    local tp = "Dap" .. type
    local hl = (type == "Stopped") and "DapStop" or "DapBreak"
    vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

-- REPL auto-completion.
local nvimCreateAutocmd = require("utils.nvim-create-autocmd")
nvimCreateAutocmd("FileType", {
    callback = function() require("dap.ext.autocompl").attach() end,
    pattern = "dap-repl",
})

-- Keymaps.
local keymap = require("utils.keymap")
keymap(
    "<leader>db",
    function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
    { desc = "Conditional [B]reakpoint" }
)
keymap("<leader>df", function()
    local w = require("dap.ui.widgets")
    w.centered_float(w.frames)
end, { desc = "Float [f]rames" })
keymap(
    "<leader>dh",
    function() require("dap.ui.widgets").hover() end,
    { desc = "[H]over value" },
    { "n", "v" }
)
keymap("<leader>dl", dap.run_last, { desc = "Run [l]ast" })
keymap(
    "<leader>dm",
    function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
    { desc = "Log point [m]essage" }
)
keymap(
    "<leader>dp",
    function() require("dap.ui.widgets").preview() end,
    { desc = "[P]review value" },
    { "n", "v" }
)
keymap("<leader>dr", dap.repl.toggle, { desc = "Toggle [R]EPL" })
keymap("<leader>ds", function()
    local w = require("dap.ui.widgets")
    w.centered_float(w.scopes)
end, { desc = "Float [s]copes" })
keymap("<leader>dx", dap.terminate, { desc = "Terminate session" })
keymap("<M-b>", dap.toggle_breakpoint, { desc = "Toggle [b]reakpoint" })
keymap("<M-c>", dap.continue, { desc = "[C]ontinue / start debugging" })
keymap("<M-down>", dap.step_over, { desc = "Step [o]ver" })
keymap("<M-left>", dap.step_out, { desc = "Step out" })
keymap("<M-right>", dap.step_into, { desc = "Step [i]nto" })
keymap("<M-up>", dap.restart_frame, { desc = "Restart frame" })
