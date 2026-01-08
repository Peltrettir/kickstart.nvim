local function add_dotnet_mappings()
  local dotnet = require 'easy-dotnet'

  vim.api.nvim_create_user_command('Secrets', function()
    dotnet.secrets()
  end, {})

  vim.keymap.set('n', '<A-t>', function()
    vim.cmd 'Dotnet testrunner'
  end, { nowait = true })

  vim.keymap.set('n', '<A-p>', function()
    vim.cmd 'Dotnet project view'
  end, { nowait = true })

  vim.keymap.set('n', '<C-p>', function()
    vim.cmd 'Dotnet debug profile default'
  end, { nowait = true })

  vim.keymap.set('n', '<c-b>', function()
    dotnet.build_default_quickfix()
  end, { nowait = true })
end

return {
  {
    'gustaveikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local dotnet = require 'easy-dotnet'
      dotnet.setup {
        ---@type easy-dotnet.TestRunner.Options
        test_runner = {
          enable_buffer_test_execution = true,
          viewmode = 'float',
          mappings = {
            debug_test_from_buffer = { lhs = '<leader>d', desc = 'debug test from buffer' },
          },
        },
        projx_lsp = {
          enabled = true,
        },
        notifications = {
          handler = false,
        },
        debugger = {
          bin_path = nil,
          apply_value_converters = true,
          auto_register_dap = true,
          mappings = {
            open_variable_viewer = { lhs = 'T', desc = 'open variable viewer' },
          },
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
  },
}
