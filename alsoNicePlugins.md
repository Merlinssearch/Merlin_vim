# Plugin Installation Tutorial for NvChad

This tutorial shows how to add recommended plugins to your existing NvChad configuration.

## Installation Method

All plugins will be added to your `lua/plugins/init.lua` file. Your current setup uses this file to define additional plugins alongside NvChad's default plugins.

## Step-by-Step Installation

### 1. Essential Plugins (Recommended to install first)

Add these to your `lua/plugins/init.lua` file by appending them to the return table:

```lua
-- Add these to your existing return table in lua/plugins/init.lua

-- File Management
{
    "stevearc/oil.nvim",
    cmd = "Oil",
    keys = {
        { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil file manager" },
    },
    config = function()
        require("oil").setup({
            columns = { "icon", "permissions", "size", "mtime" },
            view_options = {
                show_hidden = true,
            },
        })
    end,
},

-- Git Integration
{
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        })
    end,
},

-- Enhanced Diagnostics
{
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
        { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
        { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
        { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
        { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
    config = function()
        require("trouble").setup({})
    end,
},

-- TODO Comments
{
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
        { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
        { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
        { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
    config = function()
        require("todo-comments").setup({})
    end,
},
```

### 2. Code Enhancement Plugins

```lua
-- Surround Operations
{
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end,
},

-- Smart Commenting (check if NvChad already has this)
{
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("Comment").setup({})
    end,
},

-- Auto Pairs (check if NvChad already has this)
{
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({})
        -- Integration with nvim-cmp
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
},
```

### 3. UI Enhancement Plugins

```lua
-- Color Highlighter
{
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("colorizer").setup({
            "*", -- Highlight all files
        }, {
            RGB = true,      -- #RGB hex codes
            RRGGBB = true,   -- #RRGGBB hex codes
            names = true,    -- "Name" codes like Blue
            RRGGBBAA = true, -- #RRGGBBAA hex codes
            css = true,      -- Enable all CSS features
        })
    end,
},

-- Smooth Scrolling
{
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
        require("neoscroll").setup({
            mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
            hide_cursor = true,
            stop_eof = true,
            use_local_scrolloff = false,
            respect_scrolloff = false,
            cursor_scrolls_alone = true,
            easing_function = nil,
            pre_hook = nil,
            post_hook = nil,
        })
    end,
},

-- Better Notifications
{
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
        require("notify").setup({
            background_colour = "#000000",
            fps = 30,
            icons = {
                DEBUG = "",
                ERROR = "",
                INFO = "",
                TRACE = "✎",
                WARN = ""
            },
            level = 2,
            minimum_width = 50,
            render = "default",
            stages = "fade_in_slide_out",
            timeout = 5000,
            top_down = true
        })
        vim.notify = require("notify")
    end,
},
```

### 4. Advanced Git Integration

```lua
-- Advanced Git Operations
{
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit" },
    keys = {
        { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
        { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
        { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
        { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
    },
},

-- Git Diff View
{
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
        { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
        { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
        { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
    },
    config = function()
        require("diffview").setup({})
    end,
},
```

### 5. Navigation Enhancement

```lua
-- Quick File Navigation
{
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>ha", function() require("harpoon"):list():append() end, desc = "Add file to harpoon" },
        { "<leader>hm", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Toggle harpoon menu" },
        { "<leader>h1", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
        { "<leader>h2", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
        { "<leader>h3", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
        { "<leader>h4", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
        { "<leader>hp", function() require("harpoon"):list():prev() end, desc = "Previous harpoon file" },
        { "<leader>hn", function() require("harpoon"):list():next() end, desc = "Next harpoon file" },
    },
    config = function()
        require("harpoon"):setup({})
    end,
},

-- Telescope File Browser Extension
{
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "File browser" },
        { "<leader>fB", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File browser (current dir)" },
    },
    config = function()
        require("telescope").load_extension("file_browser")
    end,
},
```

### 6. Fun Plugins (Optional)

```lua
-- Make it rain! 
{
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
        { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<cr>", desc = "Make it rain" },
        { "<leader>fmg", "<cmd>CellularAutomaton game_of_life<cr>", desc = "Game of life" },
    },
},

-- Duck that waddles around
{
    "tamton-aquib/duck.nvim",
    keys = {
        { "<leader>dd", function() require("duck").hatch() end, desc = "Hatch a duck" },
        { "<leader>dk", function() require("duck").cook() end, desc = "Cook the duck" },
        { "<leader>da", function() require("duck").cook_all() end, desc = "Cook all ducks" },
    },
},
```

## Complete Updated `lua/plugins/init.lua`

Here's how your complete `lua/plugins/init.lua` should look with essential plugins:

```lua
return {
    -- Your existing plugins
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("configs.mason-lspconfig")
        end,
    },

    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
        end,
    },

    {
        "rshkarin/mason-nvim-lint",
        event = "VeryLazy",
        dependencies = { "nvim-lint" },
        config = function()
            require("configs.mason-lint")
        end,
    },

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },

    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require("configs.mason-conform")
        end,
    },

    -- NEW PLUGINS START HERE
    
    -- File Management
    {
        "stevearc/oil.nvim",
        cmd = "Oil",
        keys = {
            { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil file manager" },
        },
        config = function()
            require("oil").setup({
                columns = { "icon", "permissions", "size", "mtime" },
                view_options = {
                    show_hidden = true,
                },
            })
        end,
    },

    -- Git Integration
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
            })
        end,
    },

    -- Enhanced Diagnostics
    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" },
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
        },
        config = function()
            require("trouble").setup({})
        end,
    },

    -- TODO Comments
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
        },
        config = function()
            require("todo-comments").setup({})
        end,
    },

    -- Surround Operations
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
}
```

## Installation Steps

1. **Backup your config** (recommended):
   ```bash
   cp ~/.config/nvim/lua/plugins/init.lua ~/.config/nvim/lua/plugins/init.lua.backup
   ```

2. **Edit your plugin file**:
   ```bash
   nvim ~/.config/nvim/lua/plugins/init.lua
   ```

3. **Add the plugins** by copying the plugin configurations above into your return table

4. **Restart Neovim** and run:
   ```
   :Lazy sync
   ```

5. **Install LSP servers/formatters/linters** (if needed):
   ```
   :Mason
   ```

## Key Mappings Added

The plugins add these new key mappings:

- `<leader>e` - Open Oil file manager
- `<leader>xx` - Toggle Trouble diagnostics
- `]t` / `[t` - Jump to next/previous TODO comment
- `<leader>st` - Search TODO comments with Telescope

## Notes

- **Check for duplicates**: Some plugins might already be included in NvChad (like gitsigns, autopairs, comment). Check first to avoid conflicts.
- **Lazy loading**: All plugins are configured to lazy load for better startup performance.
- **Dependencies**: All required dependencies are specified in the plugin definitions.

## Troubleshooting

If you encounter issues:

1. Run `:checkhealth` to see if there are any problems
2. Run `:Lazy log` to see plugin loading logs
3. Restart Neovim completely
4. Check for conflicting key mappings with `:map <key>`

## Advanced: Creating Separate Plugin Files

For better organization, you can create separate files for different plugin categories:

```
lua/plugins/
├── init.lua          # Core plugins (your current setup)
├── git.lua           # Git-related plugins
├── ui.lua            # UI enhancement plugins
└── navigation.lua    # Navigation plugins
```

### How it Works (No Manual Imports Needed!)

**The magic**: Lazy.nvim automatically discovers and loads ALL `.lua` files in your `lua/plugins/` directory. You don't need to manually require or import anything!

### File Structure Example

#### `lua/plugins/init.lua` (your existing core plugins)
```lua
return {
    -- Your existing plugins (treesitter, lspconfig, etc.)
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
    },
    -- ... other core plugins
}
```

#### `lua/plugins/git.lua` (new file)
```lua
return {
    -- Git Integration
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
            })
        end,
    },

    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite" },
        keys = {
            { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
            { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
        },
    },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose" },
        keys = {
            { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
            { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
        },
        config = function()
            require("diffview").setup({})
        end,
    },
}
```

#### `lua/plugins/ui.lua` (new file)
```lua
return {
    -- Enhanced Diagnostics
    {
        "folke/trouble.nvim",
        cmd = { "Trouble", "TroubleToggle" },
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
        },
        config = function()
            require("trouble").setup({})
        end,
    },

    {
        "norcalli/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("colorizer").setup({ "*" }, {
                RGB = true,
                RRGGBB = true,
                names = true,
                css = true,
            })
        end,
    },

    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            require("notify").setup({
                background_colour = "#000000",
                timeout = 5000,
            })
            vim.notify = require("notify")
        end,
    },
}
```

#### `lua/plugins/navigation.lua` (new file)
```lua
return {
    -- File Management
    {
        "stevearc/oil.nvim",
        cmd = "Oil",
        keys = {
            { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil file manager" },
        },
        config = function()
            require("oil").setup({
                columns = { "icon", "permissions", "size", "mtime" },
                view_options = {
                    show_hidden = true,
                },
            })
        end,
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ha", function() require("harpoon"):list():append() end, desc = "Add to harpoon" },
            { "<leader>hm", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon menu" },
        },
        config = function()
            require("harpoon"):setup({})
        end,
    },
}
```

### Migration Steps

1. **Create the new files**:
   ```bash
   touch ~/.config/nvim/lua/plugins/git.lua
   touch ~/.config/nvim/lua/plugins/ui.lua
   touch ~/.config/nvim/lua/plugins/navigation.lua
   ```

2. **Move plugins from `init.lua`** to their respective category files

3. **Keep your `init.lua`** with just the core plugins (treesitter, lspconfig, etc.)

4. **Restart Neovim** - Lazy.nvim will automatically find and load all files

### Benefits

- **Better organization** - Related plugins grouped together
- **Easier maintenance** - Find and modify plugins by category
- **No performance impact** - Lazy.nvim handles everything efficiently
- **Modular** - Easy to disable entire categories by renaming files (e.g., `git.lua.disabled`)

### Important Notes

- **Every file must return a table** - Even if it's an empty table `{}`
- **No manual imports needed** - Lazy.nvim auto-discovers files
- **File names don't matter** - You can name them anything ending in `.lua`
- **Subdirectories work too** - `lua/plugins/git/init.lua` is valid

### Quick Test

After creating separate files, run in Neovim:
```vim
:Lazy
```
You should see all plugins from all files listed together. This confirms Lazy.nvim is loading everything correctly.
