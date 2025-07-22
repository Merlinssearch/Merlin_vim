local lint = require("lint")

lint.linters_by_ft = {
    lua = { "luacheck" },
    python = { "flake8" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
}

-- Configure luacheck
lint.linters.luacheck.args = {
    "--globals",
    "love",
    "vim",
    "--formatter",
    "plain",
    "--codes",
    "--ranges",
    "-",
}

-- Configure eslint_d to use config file in the same folder as lint.lua
lint.linters.eslint_d.args = {
    "--no-eslintrc", -- Don't look for config files in default locations
    "--config",
    vim.fn.stdpath("config") .. "/lua/configs/.eslintrc.json", -- Force specific path
    "--format",
    "json",
    "--stdin",
    "--stdin-filename",
}

-- Only lint on specific events to reduce errors
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        -- Only lint if we're in a supported filetype
        local ft = vim.bo.filetype
        if lint.linters_by_ft[ft] then
            lint.try_lint()
        end
    end,
})
