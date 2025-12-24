return {
  { -- Donwload packages/dlls for plugins
    'mason-org/mason.nvim',
    opts = {
      registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry',
      },
    },
  },
  { -- Auto install/enable installed servers
    'mason-org/mason-lspconfig.nvim',
    opts = {},
  },
  { -- Auto download/update mason packages
    'mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'xmlformatter',
        'csharpier',
        'prettier',
        'lua-language-server',
        'html-lsp',
        'css-lsp',
        'eslint-lsp',
        'typescript-language-server',
        'roslyn',
        'codebook',
        'lua-language-server',
        'stylua',
        'rust-analyzer',
        'json-lsp',
        'netcoredbg',
      },
      auto_update = true,
      run_on_start = true,
      debounce_hours = 4,
      integrations = {
        ['mason-lspconfig'] = true,
        ['mason-nvim-dap'] = true,
      },
    },
    config = function(_, opts)
      local plugin = require 'mason-tool-installer'
      plugin.setup(opts)
      plugin.run_on_start()
      plugin.check_install(true, true)
    end,
  },
}
