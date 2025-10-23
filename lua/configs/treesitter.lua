local options = {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "fish",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "odin",
    "printf",
    "python",
    "toml",
    "vim",
    "vimdoc",
    "yaml",
    "javascript",
    "typescript",
    "html",
    "css",
    "java",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
