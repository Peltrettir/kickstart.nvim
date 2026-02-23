return {
    {
        'nvim-orgmode/orgmode',
        event = 'VeryLazy',
        config = function()
            ---@type custom.utils
            local utils = require 'custom.utils'

            local separator, error = utils.separator()
            if not utils.is_null_or_empty(error) then
                vim.notify(error, vim.log.levels.ERROR)
                return
            end

            local user_data_folder, error = utils.user_data_folder()
            if not utils.is_null_or_empty(error) then
                vim.notify(error, vim.log.levels.ERROR)
                return
            end

            local orgmode_folder = user_data_folder .. 'orgfiles' .. separator
            error = utils.ensure_folder(orgmode_folder)
            if not utils.is_null_or_empty(error) then
                vim.notify(error, vim.log.levels.ERROR)
                return
            end

            require('orgmode.utils.treesitter.install').compilers = { 'clang' }
            require('orgmode').setup {
                org_agenda_files = orgmode_folder .. '**' .. separator .. '*',
                org_default_notes_file = orgmode_folder .. 'refile.org',
            }
            -- Experimental LSP support
            vim.lsp.enable 'org'
        end,
    },
}
