-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
    desc = 'When saving orgfiles mark reload agenda if not previously existing',
    pattern = '*.org',
    callback = function(args)
        if vim.b.org_file_existed then
            return
        end

        vim.b.org_file_existed = true
        local orgmode = require 'orgmode'
        orgmode.files:reload()
        -- orgmode.superagenda:update_agenda()
    end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
    desc = 'When opening orgfiles mark them as existing',
    pattern = '*.org',
    callback = function()
        vim.b.org_file_existed = true
    end,
})
