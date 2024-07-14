-- copilot.lua

local M = {}

-- Function to run the Golang binary and get the output
M.run_copilot = function(question)
  -- Command to run the Golang binary with the provided question
  local cmd = string.format('your_golang_binary_path "%s"', question)

  -- Capture the output of the command
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()

  -- Insert the result at the cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line = cursor_pos[1]
  local col = cursor_pos[2]

  vim.api.nvim_buf_set_text(0, line-1, col, line-1, col, {result})
end

-- Create a Neovim command that calls the Lua function
vim.api.nvim_create_user_command('copilot', function(opts)
  M.run_copilot(opts.args)
end, {nargs = 1})

return M
