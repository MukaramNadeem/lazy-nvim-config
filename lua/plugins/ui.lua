return {
    -- THEME: Catppuccin (high contrast)
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000, -- Load this before everything else
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end,
    },

    -- FILE EXPLORER: Neo-tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" },
        },
    },

    -- STATUS LINE: Lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = true, -- Runs .setup() automatically
    },
}
