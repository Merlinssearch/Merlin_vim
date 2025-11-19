require("nvchad.mappings")

local map = vim.keymap.set
local M = {}
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "java",
--   callback = function()
--     require("configs.jdtls")
--   end,
-- })
return M

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
