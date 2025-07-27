-- Force enable yank highlighting
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.ejs",
  callback = function()
    local filename = vim.fn.expand("%:p")
    local cmd =
      string.format("prettier --parser html --stdin-filepath %s", filename)
    -- write buffer, run prettier, reload file
    vim.cmd("silent write")
    vim.cmd(
      string.format(
        "silent !%s < %s > %s.tmp && mv %s.tmp %s",
        cmd,
        filename,
        filename,
        filename,
        filename
      )
    )
    vim.cmd("edit!")
  end,
})
