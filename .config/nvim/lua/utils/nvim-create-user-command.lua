return function(name, command, opts) vim.api.nvim_create_user_command(name, command, opts) end
