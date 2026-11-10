-- Getting you where you want with the fewest keystrokes.

local githubUrl = require("utils.github-url")
local packAdd = require("utils.pack-add")
packAdd({
    { src = githubUrl("ThePrimeagen/harpoon"), version = "harpoon2" }, -- https://github.com/ThePrimeagen/harpoon
})

local harpoon = require("harpoon")
harpoon:setup({
    settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
    },
})

local function toggleQuickMenu()
    harpoon.ui:toggle_quick_menu(harpoon:list(), {
        border = "single",
        height_in_lines = 10,
        title = "Harpoon",
        ui_max_width = 120,
        ui_width_ratio = 0.6,
    })
end

local keymap = require("utils.keymap")
for i = 1, 5 do
    keymap("<C-" .. i .. ">", function() harpoon:list():select(i) end, { desc = "Harpoon select " .. i })
end
keymap("<C-S-J>", function() harpoon:list():next() end, { desc = "Harpoon next" })
keymap("<C-S-K>", function() harpoon:list():prev() end, { desc = "Harpoon previous" })
keymap("<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon [a]dd" })
keymap("<leader>hc", function()
    harpoon:list():clear()
    harpoon:sync()
end, { desc = "Harpoon [c]lear" })
keymap("<leader>hp", function() harpoon:list():prepend() end, { desc = "Harpoon [p]repend" })
keymap("<M-h>", toggleQuickMenu, { desc = "[H]arpoon toggle menu" })
