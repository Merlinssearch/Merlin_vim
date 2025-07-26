return {
  {
    "vhyrro/luarocks.nvim",
    config = true,
    enabled = true,
    lazy = false,
  },
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

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      local dashboard = require("dashboard")

      -- Fixed ASCII art header with proper escaping
      local header = {
        "╭─────────────────────────────────────────────────────────────────────────────╮",
        "│               _,-'|        ███╗   ███╗███████╗██████╗ ██╗     ██╗███╗   ██╗ │",
        "│           ,-'._  |         ████╗ ████║██╔════╝██╔══██╗██║     ██║████╗  ██║ │",
        "│ .||,      |####\\ |         ██╔████╔██║█████╗  ██████╔╝██║     ██║██╔██╗ ██║ │",
        "│\\.`',/     \\####| |         ██║╚██╔╝██║██╔══╝  ██╔══██╗██║     ██║██║╚██╗██║ │",
        "│= ,. =      |###| |         ██║ ╚═╝ ██║███████╗██║  ██║███████╗██║██║ ╚████║ │",
        "│/ || \\    ,-'\\#/',`.        ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝ │",
        " │ ||     ,'   `,,. `.     ═══════════════════════════════════════════════════ │",
        "│  ,|____,' , ,;' \\| |    ✨🔮  Enter the Sanctum of Merlin's Neovim  🔮✨    │",
        "│ (3|\\    */|/'   *| |        Where code is spell and keystroke is wand.      │",
        "│  ||/,-''  | >-''  ,\\       Built on NvChad with LSP, formatting & more      │",
        "│  ||'      ==\\ ,-'  ,'                                                       │",
        "╰─────────────────────────────────────────────────────────────────────────────╯",
        "",
      }

      -- Shortcuts tailored to your NvChad setup
      local shortcuts = {
        -- Core file operations (using NvChad's telescope setup)
        {
          icon = " ",
          icon_hl = "@variable",
          desc = "Find Files",
          group = "Label",
          action = "Telescope find_files",
          key = "f",
        },
        {
          icon = " ",
          icon_hl = "@keyword",
          desc = "Recent Files",
          group = "Number",
          action = "Telescope oldfiles",
          key = "r",
        },
        {
          icon = " ",
          icon_hl = "@string",
          desc = "Find Text",
          group = "Function",
          action = "Telescope live_grep",
          key = "w", -- 'w' for word search
        },
        {
          icon = " ",
          icon_hl = "@constructor",
          desc = "File Explorer",
          group = "Constant",
          action = "NvimTreeToggle",
          key = "e",
        },

        -- Plugin and maintenance
        {
          icon = "󰊳 ",
          icon_hl = "@property",
          desc = "Update Plugins",
          group = "@property",
          action = "Lazy sync",
          key = "u",
        },
        {
          icon = "󰒲 ",
          icon_hl = "@conditional",
          desc = "Lazy Home",
          group = "Conditional",
          action = "Lazy",
          key = "L",
        },

        -- Themes and appearance (Catppuccin)
        {
          icon = " ",
          icon_hl = "@string.special",
          desc = "Change Theme",
          group = "Special",
          action = "Telescope themes",
          key = "t",
        },

        -- Health and debugging
        {
          icon = "󰓙 ",
          icon_hl = "@function.builtin",
          desc = "Check Health",
          group = "Function",
          action = "checkhealth",
          key = "h",
        },

        -- Quick exit
        {
          icon = " ",
          icon_hl = "@error",
          desc = "Quit",
          group = "Error",
          action = "qa",
          key = "q",
        },
      }

      dashboard.setup({
        theme = "hyper",
        config = {
          header = header,
          shortcut = shortcuts,
          packages = { enable = true },
          project = {
            enable = true,
            limit = 8,
            icon = "󰏓 ",
            label = " Recent Projects:",
          },
          mru = {
            limit = 8,
            icon = " ",
            label = " Recent Files:",
          },
          footer = {
            "",
            "🧙‍♂️ Built with NvChad • LSP • Formatting • Linting • Treesitter 🧙‍♂️",
            "May your code be bug-free and your syntax always highlighted!",
            "",
          },
        },
      })

      -- Custom highlights for Catppuccin theme compatibility
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          local colors = require("catppuccin.palettes").get_palette()
          if colors then
            vim.api.nvim_set_hl(
              0,
              "DashboardHeader",
              { fg = colors.blue, bold = true }
            )
            vim.api.nvim_set_hl(
              0,
              "DashboardFooter",
              { fg = colors.green, italic = true }
            )
          end
        end,
      })
    end,
  },
}
