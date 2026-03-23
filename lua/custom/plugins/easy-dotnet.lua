local function add_dotnet_mappings()
    local dotnet = require 'easy-dotnet'

    vim.api.nvim_create_user_command('Secrets', function()
        dotnet.secrets()
    end, {})

    vim.keymap.set('n', '<A-t>', function()
        vim.cmd 'Dotnet testrunner'
    end, { nowait = true, desc = 'Dotnet [T]estrunner show/hide' })

    vim.keymap.set('n', '<A-p>', function()
        vim.cmd 'Dotnet project view'
    end, { nowait = true, desc = 'Dotnet [P]roject view' })

    vim.keymap.set('n', '<C-p>', function()
        vim.cmd 'Dotnet debug profile default'
    end, { nowait = true, desc = 'Dotnet debug [P]rofile defaul' })

    vim.keymap.set('n', '<C-b>', function()
        dotnet.build_default_quickfix()
    end, { nowait = true, desc = 'Doenet [B]uild quickfix' })
end

return {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
        local dotnet = require 'easy-dotnet'
        dotnet.setup {
            test_runner = {
                enable_buffer_test_execution = true,
                viewmode = 'float',
                noBuild = false,
            },
            projx_lsp = {
                enabled = true,
            },
            notifications = {
                handler = false,
            },
            debugger = {
                -- bin_path = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason/bin/netcoredbg.cmd'),
                -- bin_path = "C:/Program Files (x86)/netcoredbg/netcoredbg.exe"
            },
            auto_bootstrap_namespace = {
                type = 'file_scoped',
                enabled = true,
            },
            server = {
                use_visual_studio = false,
                ---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
                log_level = 'Off',
            },
            terminal = function(path, action, args, ctx)
                local commands = {
                    run = function()
                        return string.format('%s %s', ctx.cmd, args)
                    end,
                    test = function()
                        return string.format('%s %s', ctx.cmd, args)
                    end,
                    restore = function()
                        return string.format('%s %s', ctx.cmd, args)
                    end,
                    build = function()
                        return string.format('%s %s', ctx.cmd, args)
                    end,
                    watch = function()
                        return string.format('dotnet watch --project %s %s', path, args)
                    end,
                }

                local command = commands[action]() .. '\r'
                require('toggleterm').exec(command, nil, nil, nil, 'float')
            end,
        }
        add_dotnet_mappings()
    end,
}
