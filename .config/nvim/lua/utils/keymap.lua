---@param lhs string
---@param rhs string|function
---@param opts? table
---@param mode? string|string[]
return function(lhs, rhs, opts, mode)
  mode = mode or "n"
  vim.keymap.set(mode, lhs, rhs, opts)
end
