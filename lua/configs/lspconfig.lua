vim.deprecate = function() end
require("java").setup()
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")

-- list of all servers configured.
lspconfig.servers = {
  "lua_ls",
  "clangd",
  "gopls",
  "ols",
  "pyright",
  "ts_ls",
  "html",
  "cssls",
}

-- Helper function to create on_attach that disables formatting
local function create_on_attach_no_formatting()
  return function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    on_attach(client, bufnr)
  end
end

-- list of servers configured with default config.
local default_servers = {
  "ols",
  "pyright",
}

-- lsps with default config
for _, lsp in ipairs(default_servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

-- Servers that need formatting disabled
lspconfig.clangd.setup({
  on_attach = create_on_attach_no_formatting(),
  on_init = on_init,
  capabilities = capabilities,
})

lspconfig.gopls.setup({
  on_attach = create_on_attach_no_formatting(),
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl", "gowork" },
  root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
    },
  },
})

-- TypeScript/JavaScript server
lspconfig.ts_ls.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
})

-- Lua server
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        enable = false, -- Disable all diagnostics from lua_ls
        -- globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
          vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/love2d/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

-- HTML and CSS servers (basic setup)
lspconfig.html.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

lspconfig.cssls.setup({
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})
