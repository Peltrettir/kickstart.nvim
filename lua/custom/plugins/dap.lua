local dap_debug_mappings = {}

local function set_debug_mappping(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
  table.insert(dap_debug_mappings, { mode = mode, lhs = lhs })
end

local function clear_debug_mappings()
  for _, m in ipairs(dap_debug_mappings) do
    pcall(vim.keymap.del, m.mode, m.lhs)
  end
  dap_debug_mappings = {}
end

function setup_dap(dap, dapui)
  dap.set_log_level 'TRACE'

  -- dap keymaps
  vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debugger continue' })
  vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = '[b]reakpoint toggle' })

  -- dap listeners
  dap.listeners.after.event_stopped['dap_ui'] = function()
    dapui.open()
    set_debug_mappping('n', '<leader>dc', dap.run_to_cursor, { desc = '[d]ebugger run to [c]ursor' })
    set_debug_mappping('n', '<leader>dr', dap.repl.toggle, { desc = '[d]ebugger toggle [r]epl' })
    set_debug_mappping('n', '<leader>dj', dap.down, { desc = '[d]ebugger move' })
    set_debug_mappping('n', '<leader>dk', dap.up, { desc = '[d]ebugger move' })
    set_debug_mappping('n', '<leader>dq', dap.close, { desc = '[d]ebugger [q]uit' })
    set_debug_mappping('n', '<F10>', dap.step_over, { desc = 'Debugger step over' })
    set_debug_mappping('n', '<F11>', dap.step_into, { desc = 'Debugger step into' })
    set_debug_mappping('n', '<F12>', dap.step_out, { desc = 'Debugger step out' })
    set_debug_mappping('n', '<F2>', require('dap.ui.widgets').hover, { desc = 'dap ui widgets' })
  end

  dap.listeners.on_session['dap_ui'] = function(_, new)
    clear_debug_mappings()
    if new == nil then
      dapui.close()
    end
  end
end

return {
  'mfussenegger/nvim-dap',
  enabled = true,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    setup_dap(dap, dapui)

    require('custom.dap-config').register_lua_dap()

    vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = 'DapBreakpoint', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '󰳟', texthl = '', linehl = 'DapStopped', numhl = '' })
  end,
  dependencies = {
    { 'jbyuki/one-small-step-for-vimkind' },
    {
      'nvim-neotest/nvim-nio',
    },
    {
      'rcarriga/nvim-dap-ui',
      config = function()
        require('dapui').setup {
          icons = { expanded = '', collapsed = '', current_frame = '' },
          mappings = {
            expand = { '<CR>' },
            open = 'o',
            remove = 'd',
            edit = 'e',
            repl = 'r',
            toggle = 't',
          },
          element_mappings = {},
          expand_lines = true,
          force_buffers = true,
          layouts = {
            {
              elements = {
                { id = 'scopes', size = 1 },
                -- {
                --   id = "repl",
                --   size = 0.66,
                -- },
              },

              size = 10,
              position = 'bottom',
            },
            {
              elements = {
                'breakpoints',
                -- "console",
                'stacks',
                'watches',
              },
              size = 45,
              position = 'right',
            },
          },
          floating = {
            max_height = nil,
            max_width = nil,
            border = 'single',
            mappings = {
              ['close'] = { 'q', '<Esc>' },
            },
          },
          controls = {
            enabled = vim.fn.exists '+winbar' == 1,
            element = 'repl',
            icons = {
              pause = '',
              play = '',
              step_into = '',
              step_over = '',
              step_out = '',
              step_back = '',
              run_last = '',
              terminate = '',
              disconnect = '',
            },
          },
          render = {
            max_type_length = nil, -- Can be integer or nil.
            max_value_lines = 100, -- Can be integer or nil.
            indent = 1,
          },
        }
      end,
    },
  },
}
