return {
    -- 1. The "Cool Animation" (Active Indent)
    {
        "echasnovski/mini.indentscope",
        version = false,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- merge all settings into one setup call to avoid resetting defaults
            require("mini.indentscope").setup({
                -- The symbol: │ is a solid vertical line. 
                -- (If you want it thicker, try "▏" instead)
                symbol = "│", 
                
                -- Animation: Sliding effect
                draw = {
                    delay = 100,
                    animation = require("mini.indentscope").gen_animation.sliding,
                },
                
                -- Behavior options
                options = { try_as_border = true },
            })

            -- Disable it for "noisy" filetypes
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "help", "dashboard", "neo-tree", "lazy", "mason", "notify", "toggleterm" },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },

    -- 2. The Standard Lines (Background Guides)
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "│" 
            },
            scope = { enabled = false },
            exclude = {
                filetypes = { "help", "dashboard", "neo-tree", "lazy", "mason", "notify", "toggleterm" },
            },
        },
    }
}