# Plugin Management Guide

This guide explains how to add, configure, and manage plugins in your NvChad-based Neovim configuration.

## Plugin Architecture Overview

The configuration uses **Lazy.nvim** as the plugin manager with the following structure:

```
.
├── lua
│   ├── configs
│   │   ├── autocmds.lua
│   │   ├── conform.lua
│   │   ├── lazy.lua
│   │   ├── lint.lua
│   │   ├── lspconfig.lua
│   │   ├── mason-conform.lua
│   │   ├── mason-lint.lua
│   │   ├── mason-lspconfig.lua
│   │   └── treesitter.lua
│   ├── plugins
│   │   └── init.lua
│   ├── chadrc.lua
│   ├── mappings.lua
│   └── options.lua
├── alsoNicePlugins.md
├── init.lua
├── Installation.md
└── Plugins.md```

## Adding New Plugins

### Method 1: Add to plugins/init.lua

Edit `lua/plugins/init.lua` and add your plugin to the return table:

```lua
return {
    -- Existing plugins...
    
    -- Add your new plugin here
    {
        "author/plugin-name",
        event = "VeryLazy",  -- or other lazy-loading events
        config = function()
            -- Plugin configuration
        end,
    },
    
    -- Another example with dependencies
    {
        "author/another-plugin",
        dependencies = { "required/dependency" },
        cmd = "PluginCommand",  -- Load only when command is used
        config = function()
            require("plugin").setup({
                -- plugin options
            })
        end,
    },
}
```

### Method 2: Create separate plugin files

For complex plugins, create separate files in `lua/plugins/`:

1. Create `lua/plugins/my-plugin.lua`:
```lua
return {
    "author/plugin-name",
    event = "BufReadPre",
    config = function()
        require("configs.my-plugin")
    end,
}
```

2. Create configuration in `lua/configs/my-plugin.lua`:
```lua
local options = {
    -- Plugin configuration options
}

require("plugin-name").setup(options)
```

3. Update `lua/plugins/init.lua` to import:
```lua
return {
    -- Existing plugins...
    
    { import = "plugins.my-plugin" },
}
```

## Adding Language Support

### Adding a New LSP Server

1. **Edit `lua/configs/lspconfig.lua`:**
```lua
-- Add to the servers list
lspconfig.servers = {
    "lua_ls",
    "clangd",
    -- ... existing servers
    "your_new_lsp",  -- Add here
}

-- Add to default_servers if it needs basic config
local default_servers = {
    "ols",
    "pyright",
    "your_new_lsp",  -- Add here if using default config
}

-- Or configure separately for custom settings
lspconfig.your_new_lsp.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    settings = {
        -- Custom LSP settings
    },
})
```

### Adding a New Formatter

1. **Edit `lua/configs/conform.lua`:**
```lua
local options = {
    formatters_by_ft = {
        -- Existing formatters...
        your_language = { "your_formatter" },
    },

    formatters = {
        -- Existing formatters...
        your_formatter = {
            prepend_args = { "--custom-arg" },
        },
    },
}
```

### Adding a New Linter

1. **Edit `lua/configs/lint.lua`:**
```lua
lint.linters_by_ft = {
    -- Existing linters...
    your_language = { "your_linter" },
}

-- Configure linter if needed
lint.linters.your_linter.args = {
    "--custom-args",
}
```

### Adding Treesitter Support

1. **Edit `lua/configs/treesitter.lua`:**
```lua
local options = {
    ensure_installed = {
        -- Existing languages...
        "your_language",
    },
}
```

## Common Plugin Categories

### UI Enhancement Plugins

```lua
-- Status line
{
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        require("lualine").setup()
    end,
},

-- File explorer
{
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function()
        require("nvim-tree").setup()
    end,
},
```

### Development Tools

```lua
-- Git integration
{
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("gitsigns").setup()
    end,
},

-- Debugging
{
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function()
        require("configs.dap")
    end,
},
```

### Language-Specific Plugins

```lua
-- Rust tools
{
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
        require("rust-tools").setup()
    end,
},

-- Go tools
{
    "ray-x/go.nvim",
    ft = "go",
    config = function()
        require("go").setup()
    end,
},
```

## Plugin Loading Strategies

### Lazy Loading Events

- `event = "VeryLazy"` - Load after Neovim startup
- `event = "BufReadPre"` - Load before reading any file
- `event = { "BufReadPre", "BufNewFile" }` - Load on file operations
- `ft = "python"` - Load only for Python files
- `cmd = "CommandName"` - Load when command is executed
- `keys = "<leader>key"` - Load when key is pressed

### Dependencies

```lua
{
    "main-plugin/name",
    dependencies = {
        "required/plugin",
        { "optional/plugin", config = function() end },
    },
}
```

## Managing Plugins

### Lazy.nvim Commands

```bash
# Open Lazy plugin manager
:Lazy

# Install new plugins
:Lazy install

# Update all plugins
:Lazy update

# Clean unused plugins
:Lazy clean

# Check plugin status
:Lazy check

# Profile startup time
:Lazy profile
```

### Mason Commands

```bash
# Open Mason (for LSP, formatters, linters)
:Mason

# Install a package
:MasonInstall package_name

# Update all packages
:MasonUpdate

# Uninstall a package
:MasonUninstall package_name
```

## Troubleshooting Plugins

### Plugin Not Loading
1. Check the plugin specification in `init.lua`
2. Verify dependencies are installed
3. Check for syntax errors: `:Lazy check`

### Configuration Errors
1. Check Neovim messages: `:messages`
2. Check plugin health: `:checkhealth plugin_name`
3. Test configuration: `:lua require("plugin").setup()`

### Performance Issues
1. Profile startup: `:Lazy profile`
2. Check which plugins are loading early
3. Optimize lazy loading events

## Example: Adding a Complete Language Setup

Let's add Rust support as an example:

1. **Add LSP server in `lspconfig.lua`:**
```lua
lspconfig.servers = {
    -- existing servers...
    "rust_analyzer",
}

-- Add to default servers or configure separately
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
        },
    },
})
```

2. **Add formatter in `conform.lua`:**
```lua
formatters_by_ft = {
    -- existing formatters...
    rust = { "rustfmt" },
}
```

3. **Add Treesitter support in `treesitter.lua`:**
```lua
ensure_installed = {
    -- existing languages...
    "rust",
}
```

4. **Add Rust-specific plugin in `plugins/init.lua`:**
```lua
{
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
        require("rust-tools").setup({
            server = {
                on_attach = function(client, bufnr)
                    require("nvchad.configs.lspconfig").on_attach(client, bufnr)
                end,
            },
        })
    end,
},
```

## Best Practices

1. **Use lazy loading** to improve startup time
2. **Group related configurations** in separate files
3. **Test plugins individually** before adding multiple plugins
4. **Keep configurations minimal** - only override defaults when necessary
5. **Document custom keybindings** in `mappings.lua`
6. **Use Mason** for automatic tool installation when possible
7. **Regular updates** but test configurations after updates

## Useful Resources

- [Lazy.nvim Documentation](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [NvChad Documentation](https://nvchad.com/)
- [Neovim Plugin Directory](https://dotfyle.com/neovim/plugins)
- [Rainbow Config](https://github.com/ProgrammingRainbow/NvChad-2.5)
