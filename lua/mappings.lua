require("nvchad.mappings")

local map = vim.keymap.set
local M = {}
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
return M
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
