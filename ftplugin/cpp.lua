-- 1. C++ Standard Indentation
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true

-- 2. Run C++ File (<Space>r) - Clean Version
vim.keymap.set("n", "<leader>r", function()
local file = vim.fn.expand("%:p")       -- Full path to current file
local fileName = vim.fn.expand("%:t:r") -- Just the filename (e.g., "main")

-- saving the binary to the system temp folder so it doesn't clutter the project
local output = "/tmp/" .. fileName

vim.cmd("write")

-- The Command:
-- 1. Compile to /tmp/
-- 2. Run it
-- 3. Delete it immediately after running
local cmd = "g++ -std=c++17 -Wall " .. file .. " -o " .. output .. " && " .. output .. " && rm " .. output

vim.cmd("split | term " .. cmd)
end, { desc = "Compile and Run C++ (Clean)" })
