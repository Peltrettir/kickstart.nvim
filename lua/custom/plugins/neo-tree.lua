-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    {
      '-',
      function()
        local reveal_file = vim.fn.expand '%:p'
        if reveal_file == '' then
          reveal_file = vim.fn.getcwd()
        else
          local f = io.open(reveal_file, 'r')
          if f then
            f.close(f)
          else
            reveal_file = vim.fn.getcwd()
          end
        end
        require('neo-tree.command').execute {
          action = 'focus', -- OPTIONAL, this is the default value
          source = 'filesystem', -- OPTIONAL, this is the default value
          position = 'left', -- OPTIONAL, this is the default value
          reveal_file = reveal_file, -- path to file or folder to reveal
          reveal_force_cwd = true, -- change cwd without asking if needed
        }
      end,
      desc = 'Open neo-tree at current file or working directory',
      silent = true,
    },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
