require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set
local M = {}
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

M.java = {
  n = {
    ["<leader>jr"] = { "<cmd>JavaRunnerRunMain<cr>", "Run Java Main" },
    ["<leader>js"] = { "<cmd>JavaRunnerStopMain<cr>", "Stop Java Main" },
    ["<leader>jt"] = { "<cmd>JavaTestRunCurrentClass<cr>", "Run Test Class" },
    ["<leader>jd"] = {
      "<cmd>JavaTestDebugCurrentClass<cr>",
      "Debug Test Class",
    },
    ["<leader>jm"] = { "<cmd>JavaTestRunCurrentMethod<cr>", "Run Test Method" },
    ["<leader>jp"] = { "<cmd>JavaProfile<cr>", "Java Profiles" },
    ["<leader>jb"] = { "<cmd>JavaBuildBuildWorkspace<cr>", "Build Workspace" },
    ["<leader>jc"] = { "<cmd>JavaBuildCleanWorkspace<cr>", "Clean Workspace" },
  },
}
return M
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
