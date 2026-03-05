-- return {
--     "nvim-telescope/telescope.nvim",
--     tag = "0.1.6",
--     dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
--     config = function()
--         local builtin = require("telescope.builtin")
--         vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find Files" })
--         vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Text (Grep)" })
--         vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Find Buffers" })
--     end,
-- }

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x", -- Use the latest stable branch instead of a specific pinned tag
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find Files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Text (Grep)" })
        vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Find Buffers" })
    end,
}