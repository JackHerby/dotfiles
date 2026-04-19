return function(lhs, rhs, opts, mode)
  mode = mode or "n"
  vim.keymap.set(mode, lhs, rhs, opts)
end
