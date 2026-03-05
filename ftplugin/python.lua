
-- Custom Keymap: Run the current Python file
-- This maps <Space>r to save the file and run it
vim.keymap.set("n", "<leader>r", function()
  -- 1. Save the file
  vim.cmd("write")
  
  -- 2. Open a horizontal split terminal and run python3
  -- Use '%' to get the current file name
  vim.cmd("split | term python3 " .. vim.fn.expand("%"))
end, { desc = "Run Python File" })
