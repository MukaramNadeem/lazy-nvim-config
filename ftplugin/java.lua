-- -- ~/.config/nvim/ftplugin/java.lua

-- local jdtls = require('jdtls')

-- -- 1. Find the path to the jdtls installation managed by Mason
-- local home = os.getenv('HOME')
-- local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
-- local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- -- 2. Determine the OS configuration (Linux, Mac, or Windows)
-- local config_path = mason_path .. "/config_linux"
-- if vim.fn.has('mac') == 1 then
--     config_path = mason_path .. "/config_mac"
-- elseif vim.fn.has('win32') == 1 then
--     config_path = mason_path .. "/config_win"
-- end

-- -- 3. Define the workspace data directory
-- -- This ensures every project has its own unique data folder
-- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
-- local workspace_dir = home .. '/.cache/jdtls-workspace/' .. project_name

-- -- 4. The command to start the server
-- local config = {
--     cmd = {
--         'java', -- Or absolute path to java 17+ executable
--         '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--         '-Dosgi.bundles.defaultStartLevel=4',
--         '-Declipse.product=org.eclipse.jdt.ls.core.product',
--         '-Dlog.protocol=true',
--         '-Dlog.level=ALL',
--         '-Xmx1g',
--         '--add-modules=ALL-SYSTEM',
--         '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--         '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        
--         -- Path to the launcher jar
--         '-jar', launcher_jar,
        
--         -- Path to the configuration (OS specific)
--         '-configuration', config_path,
        
--         -- Path to the workspace data
--         '-data', workspace_dir,
--     },
--     root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),
    
--     -- Here we attach the settings
--     settings = {
--         java = {
--             signatureHelp = { enabled = true },
--             contentProvider = { preferred = "fernflower" }, -- Decompiler
--             completion = {
--                 favoriteStaticMembers = {
--                     "org.hamcrest.MatcherAssert.assertThat",
--                     "org.hamcrest.Matchers.*",
--                     "org.hamcrest.CoreMatchers.*",
--                     "org.junit.jupiter.api.Assertions.*",
--                     "java.util.Objects.requireNonNull",
--                     "java.util.Objects.requireNonNullElse",
--                     "org.mockito.Mockito.*"
--                 },
--                 importOrder = {
--                     "java",
--                     "javax",
--                     "com",
--                     "org"
--                 },
--             },
--             sources = {
--                 organizeImports = {
--                     starThreshold = 9999,
--                     staticStarThreshold = 9999,
--                 },
--             },
--             codeGeneration = {
--                 toString = {
--                     template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
--                 },
--             },
--         },
--     },
-- }

-- -- 5. Attach the LSP client and set Keymaps
-- config.on_attach = function(client, bufnr)
--     local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--     local opts = { noremap=true, silent=true }

--     -- Standard LSP keymaps (Go to definition, etc.) are already handled by your lsp.lua 
--     -- if you used the LspAttach autocmd. If not, you can duplicate them here.
    
--     -- Java Specific Keymaps
--     buf_set_keymap("n", "<leader>jo", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts) -- Organize Imports
--     buf_set_keymap("n", "<leader>jv", "<cmd>lua require('jdtls').extract_variable()<CR>", opts) -- Extract Variable
--     buf_set_keymap("n", "<leader>jc", "<cmd>lua require('jdtls').extract_constant()<CR>", opts) -- Extract Constant
--     buf_set_keymap("v", "<leader>jm", "<Esc><cmd>lua require('jdtls').extract_method(true)<CR>", opts) -- Extract Method
-- end

-- -- 6. Setup Completion (nvim-cmp integration)
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- config.capabilities = capabilities

-- -- 7. Start the server
-- jdtls.start_or_attach(config)





































local jdtls = require('jdtls')

-- 1. Calculate Paths
local home = os.getenv('HOME')
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- SAFETY CHECK: If the jar isn't found, stop here to avoid the "Unable to access jarfile" error
if launcher_jar == "" then
    vim.notify("JDTLS Error: Launcher JAR not found in " .. mason_path, vim.log.levels.ERROR)
    return
end

-- 2. Determine OS Config
local config_path = mason_path .. "/config_linux"
if vim.fn.has('mac') == 1 then
    config_path = mason_path .. "/config_mac"
elseif vim.fn.has('win32') == 1 then
    config_path = mason_path .. "/config_win"
end

-- 3. Workspace Directory
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/.cache/jdtls-workspace/' .. project_name

-- 4. Setup Configuration
local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', launcher_jar,
        '-configuration', config_path,
        '-data', workspace_dir,
    },
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                }
            },
            sources = {
                organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
            },
        },
    },
}

-- 5. Attach Keymaps
config.on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }
    buf_set_keymap("n", "<leader>jo", "<cmd>lua require'jdtls'.organize_imports()<CR>", opts)
    buf_set_keymap("n", "<leader>jv", "<cmd>lua require('jdtls').extract_variable()<CR>", opts)
    buf_set_keymap("n", "<leader>jc", "<cmd>lua require('jdtls').extract_constant()<CR>", opts)
    buf_set_keymap("v", "<leader>jm", "<Esc><cmd>lua require('jdtls').extract_method(true)<CR>", opts)
end

-- 6. Setup Capabilities (Completion)
local capabilities = require('cmp_nvim_lsp').default_capabilities()
config.capabilities = capabilities

-- 7. Start
jdtls.start_or_attach(config)



















-- ... ( code) ...

-- Custom Keymap: Run the current Java file in a floating terminal
-- This maps <Space>r to save the file and run it
vim.keymap.set("n", "<leader>r", function()
  -- 1. Save the file
  vim.cmd("write")
  
  -- 2. Open a horizontal split terminal
  vim.cmd("split | term java " .. vim.fn.expand("%"))
end, { desc = "Run Java File" })