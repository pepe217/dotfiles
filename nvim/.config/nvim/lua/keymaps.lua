-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- neovide specific things
if vim.g.neovide then
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
  vim.keymap.set('n', '<D-q>', ':wqall<CR>')
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

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>bt', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' })
vim.keymap.set('n', '<leader>bd', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle diagnostic' })

-- Better exit terminal key
vim.keymap.set('t', '`', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Use Alt-hjkl to move between splits.
local movement_keys = { 'h', 'j', 'k', 'l' }
local mac_option_keys = { '˙', '∆', '˚', '¬' }
for key_index = 1, #movement_keys do
  vim.keymap.set({ '', 'i' }, string.format('<M-%s>', movement_keys[key_index]), string.format('<Esc><C-w>%s', movement_keys[key_index]), { noremap = true })
  vim.keymap.set('t', string.format('<M-%s>', movement_keys[key_index]), string.format('<C-\\><C-n><C-w>%s', movement_keys[key_index]), { noremap = true })
  vim.keymap.set({ '', 'i' }, mac_option_keys[key_index], string.format('<Esc><C-w>%s', movement_keys[key_index]), { noremap = true })
  vim.keymap.set('t', mac_option_keys[key_index], string.format('<C-\\><C-n><C-w>%s', movement_keys[key_index]), { noremap = true })
end

-- easy open terminals
vim.keymap.set('n', '<leader>bb', '<Cmd>term<CR>', { noremap = true, desc = 'Terminal in existing window' })
vim.keymap.set('n', '<leader>bv', '<Cmd>vsplit term://zsh<CR>', { noremap = true, desc = 'Terminal in vsplit window' })
vim.keymap.set('n', '<leader>bs', '<Cmd>split term://zsh<CR>', { noremap = true, desc = 'Terminal in split window' })

-- Faster window resizing
vim.keymap.set('n', '<leader>=', '<C-w>=', { desc = 'Set window sizes equal' })

-- easier save and close
vim.keymap.set('n', '<leader>f', ':w<CR>', { desc = 'save' })
vim.keymap.set('n', '<leader>t', ':x<CR>', { desc = 'exit' })

-- github convenience links
local github_url = function()
  local rel_path = vim.fn.expand '%:.'
  local repo_path = 'https://github.com/pepe217/dotfiles/blob/'
  local branch = vim.fn.systemlist('git symbolic-ref --short HEAD')[1]
  local line = vim.fn.line '.'
  vim.fn.setreg('+', repo_path .. branch .. '/' .. rel_path .. '#L' .. line)
end
vim.keymap.set('n', '<leader>gw', github_url, { desc = 'Copy github link to clipboard' })
vim.keymap.set('n', '<leader>go', function()
  vim.fn.jobstart({ 'xdg_open', github_url() }, { detach = true })
end, { desc = 'Open github link in browser' })
