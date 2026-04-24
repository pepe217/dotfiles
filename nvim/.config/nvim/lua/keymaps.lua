-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap jk -> Esc.
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })
-- neovide specific things
if vim.g.neovide then
  -- Copy/paste with cmd key
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  -- vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  -- vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
  vim.keymap.set('n', '<D-q>', ':wqall<CR>')
  -- Scaling on the fly
  vim.keymap.set({ 'n', 'v' }, '<D-+>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>')
  vim.keymap.set({ 'n', 'v' }, '<D-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>')
  vim.keymap.set({ 'n', 'v' }, '<D-=>', ':lua vim.g.neovide_scale_factor = 1<CR>')
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', 'jj', '<ESC>', { silent = true })

-- Keeping the cursor centered.
vim.keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'Page downwards' })
vim.keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'Page upwards' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll downwards' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll upwards' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous result' })

-- Diagnostic keymaps
vim.keymap.set('n', 'gK', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' })
vim.keymap.set('n', 'gk', function()
  local new_config = not vim.diagnostic.config().virtual_text
  vim.diagnostic.config { virtual_text = new_config }
end, { desc = 'Toggle diagnostic virtual_text' })
vim.keymap.set('n', 'E', vim.diagnostic.open_float, { desc = 'Open diagnostic floating window' })

-- Easier exit terminal key
vim.keymap.set('t', '`', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Paste from register into terminal buffer
vim.keymap.set('t', '<M-r>', [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true })

-- Faster window resizing
vim.keymap.set('n', '<leader>=', '<C-w>=', { desc = 'Set window sizes equal' })

-- easier save and close
vim.keymap.set('n', '<leader>f', ':w<CR>', { desc = 'save' })
vim.keymap.set('n', '<leader>t', ':x<CR>', { desc = 'save and exit' })
