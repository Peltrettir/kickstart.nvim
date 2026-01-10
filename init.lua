local sep = package.config:sub(1, 1)
local base_path = string.sub(debug.getinfo(1).source, 2, string.len '/init.lua' * -1 - 1)
local rtp = vim.opt.rtp

package.path = base_path
    .. sep
    .. '?.lua;'
    .. base_path
    .. sep
    .. '?'
    .. sep
    .. 'init.lua;'
    .. base_path
    .. sep
    .. 'lua'
    .. sep
    .. '?.lua;'
    .. base_path
    .. sep
    .. 'lua'
    .. '?'
    .. sep
    .. 'init.lua;'
    .. package.path

rtp:prepend(base_path)

require 'custom.set'
require 'custom.autocommands'
require 'custom.keymap'

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

---@type vim.Option
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
    -- NOTE: Plugins can specify dependencies.

    --  Here are some example plugins that I've included in the Kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    -- require 'kickstart.plugins.lint',
    -- require 'kickstart.plugins.autopairs',
    { import = 'custom.plugins' },
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
