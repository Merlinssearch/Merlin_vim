require("nvchad.options")

local o = vim.o
-- Indenting
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.cursorcolumn = true
o.cursorline = true
--o.cursorlineopt = "both" -- to enable cursorline!
-- Search improvements
o.ignorecase = true
o.smartcase = true
o.hlsearch = true

-- Better splits
o.splitright = true
o.splitbelow = true

-- Line numbers
o.relativenumber = true

-- Scrolling
o.scrolloff = 8
o.sidescrolloff = 8
-- set filetype for .CBL COBOL files.
-- vim.cmd([[ au BufRead,BufNewFile *.CBL set filetype=cobol ]])
