return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
        -- 1. Setup Variables
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local lspconfig = require("lspconfig")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
                                                 cmp_lsp.default_capabilities()
        )

        -- 2. Setup Mason
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "jdtls", "pyright", "ruff", "clangd" },
            handlers = {
                -- Default Handler
                function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
                end,

                -- Python (Pyright)
        ["pyright"] = function()
        lspconfig.pyright.setup({
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })
        end,

        -- Python (Ruff)
        ["ruff"] = function()
        lspconfig.ruff.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
            if client.name == 'ruff' then
                client.server_capabilities.hoverProvider = false
                end
                end,
        })
        end,

        -- C++ (Clangd)
        ["clangd"] = function()
        lspconfig.clangd.setup({
            capabilities = capabilities,
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--fallback-style=llvm",
            },
            init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
            },
        })
        end,

        -- Lua
        ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
            },
        })
        end,
            },
        }) 

        -- 3. Setup Autocomplete (CMP)
        cmp.setup({
            snippet = {
                expand = function(args)
                require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                                                ["<C-n>"] = cmp.mapping.select_next_item(),
                                                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                                                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),
        })
        end,
    },
}
