-- [[ Setting global options ]]
vim.g.mapleader = ' '

vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- [[ Setting options ]]
vim.o.number = true

vim.o.relativenumber = true

vim.o.mouse = 'a'

vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true

vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 250

vim.o.timeoutlen = 300

vim.o.splitright = true

vim.o.splitbelow = false

vim.o.list = true

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split'

vim.o.cursorline = true

vim.o.scrolloff = 10

vim.o.confirm = true

vim.o.foldmethod = 'indent'

vim.o.foldenable = false

vim.o.foldlevel = 99
