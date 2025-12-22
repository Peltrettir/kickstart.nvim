-- [[ Basic Keymaps ]]

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- NOTE: Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Windows default association don't require GUI applications
-- manually mapped text files to nvim
vim.keymap.set('n', 'gx', function()
  local target = vim.fn.expand '<cfile>'

  local nvim_extensions = {
    md = true,
    txt = true,
    log = true,
    cs = true,
    py = true,
    json = true,
  }

  -- helper: extract extension
  local function get_ext(path)
    return path:match '^.+%.([^./\\#]+)' -- ignores anchors
  end

  -- helper: strip markdown anchors
  local ext = get_ext(target:gsub('#.*$', ''))

  -- use Neovim only if:
  --   - no extension
  --   - or extension explicitly allowed
  if ext == nil or nvim_extensions[ext:lower()] then
    vim.cmd('edit ' .. vim.fn.fnameescape(target))
    return
  end

  -- otherwise, delegate to OS default
  vim.fn.jobstart({ 'cmd', '/c', 'start', target }, { detach = true })
end, { silent = true })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })
