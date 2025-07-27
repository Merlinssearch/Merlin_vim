vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
vim.g.mapleader = " "

require("configs.autocmds")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ejs",
  callback = function()
    vim.bo.filetype = "html"
  end,
})
-- Bootstrap lazy.nvim BEFORE requiring it
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    repo,
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Jetzt lazy laden - Path ist gesetzt
local lazy = require("lazy")

-- Lazy Konfiguration und Pluginliste laden
local lazy_config = require("configs.lazy")
local lazy_plugins = {
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require("options")
    end,
  },

  { import = "plugins" },

  --Markdown ecosystem
  {
    "MeanderingProgrammer/markdown.nvim",
    ft = "markdown",
    opts = {},
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown", "norg", "org" },
    config = function()
      require("headlines").setup({
        markdown = {
          headline_highlights = { "Headline1", "Headline2", "Headline3" },
          codeblock_highlight = "CodeBlock",
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    opts = {
      ensure_installed = { "markdown", "markdown_inline", "latex", "html" },
      highlight = { enable = true },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && npm install",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
  },

  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
    init = function()
      vim.g.table_mode_map_prefix = "<leader>tm"
    end,
  },
}

-- Setup lazy.nvim mit Plugins und Config
lazy.setup(lazy_plugins, lazy_config)

-- Load theme & statusline
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("nvchad.autocmds")

vim.schedule(function()
  require("mappings")
end)
