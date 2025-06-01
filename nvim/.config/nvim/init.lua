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

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

vim.opt.spell = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 4

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.diagnostic.config { virtual_lines = true }

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

-- Enter insert mode when entering a terminal window.
vim.api.nvim_create_autocmd({ 'BufEnter', 'TermOpen' }, {
  pattern = 'term://*',
  command = 'startinsert',
})

-- Allow modification in terminal output and disable the warning for the buffer
-- being modified when closing
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.modifiable = true
    vim.opt.modified = false
  end,
})
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

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

vim.api.nvim_create_autocmd({ 'BufDelete', 'BufWipeout' }, {
  group = vim.api.nvim_create_augroup('wshada_on_buf_delete', { clear = true }),
  desc = 'Write to ShaDa when deleting/wiping out buffers',
  command = 'wshada',
})
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- easier save and close
vim.keymap.set('n', '<leader>f', ':w<CR>', { desc = 'save' })
vim.keymap.set('n', '<leader>t', ':x<CR>', { desc = 'exit' })

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require 'lsp'

require('lazy').setup('plugins', {
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
