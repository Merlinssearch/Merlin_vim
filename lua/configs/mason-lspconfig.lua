-- local lspconfig = require("lspconfig")
--
-- -- List of servers to ignore during install
-- local ignore_install = {
--     -- Add any servers you want to skip here
--     -- "hls",  -- Example: if you don't want Haskell LSP
-- }
--
-- -- Valid server names (update this as needed)
-- local valid_servers = {
--     "lua_ls",
--     "clangd",
--     "gopls",
--     "ols",
--     "pyright",
--     "tsserver",
--     "html",
--     "cssls",
-- }
--
-- -- Filter valid servers
-- local all_servers = {}
-- for _, s in ipairs(valid_servers) do
--     if not vim.tbl_contains(ignore_install, s) then
--         table.insert(all_servers, s)
--     end
-- end
--
-- require("mason-lspconfig").setup({
--     ensure_installed = all_servers,
--     automatic_installation = false,
-- })

local lspconfig = package.loaded["lspconfig"]

-- List of servers to ignore during install
local ignore_install = {
    "hls",
}

-- Helper function to find if value is in table.
local function table_contains(table, value)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

-- Build a list of lsp servers to install minus the ignored list.
local all_servers = {}
for _, s in ipairs(lspconfig.servers) do
    if not table_contains(ignore_install, s) then
        table.insert(all_servers, s)
    end
end

require("mason-lspconfig").setup({
    ensure_installed = all_servers,
    automatic_installation = false,
})
