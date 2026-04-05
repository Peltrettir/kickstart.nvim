-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ 'FileType', 'BufWinEnter' }, {
    desc = 'User treesitter folding whenever available',
    group = vim.api.nvim_create_augroup('LspFolding', { clear = true }),
    callback = function(args)
        local ok = pcall(vim.treesitter.get_parser, args.buf)
        if ok then
            vim.api.nvim_buf_call(args.buf, function()
                vim.wo.foldmethod = 'expr'
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            end)
        end
    end,
})

-- vim.api.nvim_create_autocmd('BufWritePost', {
--     desc = 'When saving orgfiles mark reload agenda if not previously existing',
--     pattern = '*.org',
--     callback = function(args)
--         if vim.b.org_file_existed then
--             return
--         end
--
--         vim.b.org_file_existed = true
--         local orgmode = require 'orgmode'
--         orgmode.files:reload()
--         -- orgmode.superagenda:update_agenda()
--     end,
-- })
--
-- vim.api.nvim_create_autocmd('BufReadPost', {
--     desc = 'When opening orgfiles mark them as existing',
--     pattern = '*.org',
--     callback = function()
--         vim.b.org_file_existed = true
--     end,
-- })
