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
vim.keymap.set('n', '<D-h>', '5<C-w><', { desc = 'Decrease window width' })
vim.keymap.set('n', '<D-l>', '5<C-w>>', { desc = 'Increase window width' })
vim.keymap.set('n', '<D-j>', '5<C-w>-', { desc = 'Decrease window height' })
vim.keymap.set('n', '<D-k>', '5<C-w>+', { desc = 'Increase window height' })
vim.keymap.set('n', '<leader>=', '<C-w>=', { desc = 'Set window sizes equal' })

-- Enter insert mode when entering a terminal window.
vim.api.nvim_create_autocmd({ 'BufEnter', 'TermOpen' }, {
  pattern = 'term://*',
  command = 'startinsert',
})

-- Disable line numbers in terminal buffers
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
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

vim.keymap.set('n', ']e', function()
  vim.diagnostic.jump { float = false, count = 1, severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN } }
end, { desc = 'Next Warn/Error' })
vim.keymap.set('n', '[e', function()
  vim.diagnostic.jump { float = false, count = -1, severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN } }
end, { desc = 'Prev Warn/Error' })

require('lazy').setup({
  'mbbill/undotree',
  {
    'MagicDuck/grug-far.nvim',
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>dg',
        function()
          local grug = require 'grug-far'
          grug.open {
            transient = true,
            keymaps = { help = '?' },
          }
        end,
        desc = 'GrugFar',
        mode = { 'n', 'v' },
      },
    },
  },
  {
    'stevearc/quicker.nvim',
    event = 'VeryLazy',
    opts = {
      borders = {
        -- Thinner separator.
        vert = '│',
      },
    },
    keys = {
      {
        '<leader>Q',
        function()
          require('quicker').toggle()
        end,
        desc = 'Toggle quickfix',
      },
      {
        '<leader>L',
        function()
          require('quicker').toggle { loclist = true }
        end,
        desc = 'Toggle loclist list',
      },
      {
        '<leader>l',
        function()
          local quicker = require 'quicker'

          if quicker.is_open() then
            quicker.close()
          else
            vim.diagnostic.setloclist()
          end
        end,
        desc = 'Toggle diagnostics (loc)',
      },
      {
        '<leader>q',
        function()
          local quicker = require 'quicker'

          if quicker.is_open() then
            quicker.close()
          else
            vim.diagnostic.setqflist()
          end
        end,
        desc = 'Toggle diagnostics (qf)',
      },
      {
        '>',
        function()
          require('quicker').expand { before = 2, after = 2, add_to_existing = true }
        end,
        desc = 'Expand context',
      },
      {
        '<',
        function()
          require('quicker').collapse()
        end,
        desc = 'Collapse context',
      },
    },
  },
  {
    'jake-stewart/multicursor.nvim',
    config = function()
      local mc = require 'multicursor-nvim'

      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({ 'n', 'v' }, '<up>', function()
        mc.lineAddCursor(-1)
      end)
      set({ 'n', 'v' }, '<down>', function()
        mc.lineAddCursor(1)
      end)
      set({ 'n', 'v' }, '<leader><up>', function()
        mc.lineSkipCursor(-1)
      end)
      set({ 'n', 'v' }, '<leader><down>', function()
        mc.lineSkipCursor(1)
      end)

      -- Add or skip adding a new cursor by matching word/selection
      set({ 'n', 'v' }, '<leader>cn', function()
        mc.matchAddCursor(1)
      end)
      set({ 'n', 'v' }, '<leader>cs', function()
        mc.matchSkipCursor(1)
      end)
      set({ 'n', 'v' }, '<leader>cN', function()
        mc.matchAddCursor(-1)
      end)
      set({ 'n', 'v' }, '<leader>cS', function()
        mc.matchSkipCursor(-1)
      end)

      -- Add all matches in the document
      set({ 'n', 'v' }, '<leader>ca', mc.matchAllAddCursors)

      -- Rotate the main cursor.
      set({ 'n', 'v' }, '<left>', mc.nextCursor)
      set({ 'n', 'v' }, '<right>', mc.prevCursor)

      -- Delete the main cursor.
      set({ 'n', 'v' }, '<leader>cx', mc.deleteCursor)

      -- Easy way to add and remove cursors using the main cursor.
      set({ 'n', 'v' }, '<leader>cq', mc.toggleCursor)

      -- Clone every cursor and disable the originals.
      set({ 'n', 'v' }, '<leader>cd', mc.duplicateCursors)

      set('n', '<esc>', function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          vim.cmd 'nohlsearch'
        end
      end)

      -- bring back cursors if you accidentally clear them
      set('n', '<leader>cv', mc.restoreCursors)

      -- Align cursor columns.
      set('n', '<leader>cl', mc.alignCursors)

      -- Split visual selections by regex.
      set('v', 'S', mc.splitCursors)

      -- Append/insert for each line of visual selections.
      set('v', 'I', mc.insertVisual)
      set('v', 'A', mc.appendVisual)

      -- match new cursors within visual selections by regex.
      set('v', 'M', mc.matchCursors)

      -- Rotate visual selection contents.
      set('v', '<leader>t', function()
        mc.transposeCursors(1)
      end)
      set('v', '<leader>T', function()
        mc.transposeCursors(-1)
      end)

      -- Jumplist support
      set({ 'v', 'n' }, '<c-i>', mc.jumpForward)
      set({ 'v', 'n' }, '<c-o>', mc.jumpBackward)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, 'MultiCursorCursor', { link = 'Cursor' })
      hl(0, 'MultiCursorVisual', { link = 'Visual' })
      hl(0, 'MultiCursorSign', { link = 'SignColumn' })
      hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
      hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
      hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
    end,
  },
  {
    'gbprod/yanky.nvim',
    opts = {
      ring = { history_length = 20 },
      highlight = { timer = 250 },
    },
    keys = {
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
      { '=p', '<Plug>(YankyPutAfterLinewise)', desc = 'Put yanked text in line below' },
      { '=P', '<Plug>(YankyPutBeforeLinewise)', desc = 'Put yanked text in line above' },
      { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle forward through yank history' },
      { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle backward through yank history' },
      { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yanky yank' },
    },
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      picker = {
        enabled = true,
      },
      words = { enabled = true },
      indent = { enabled = true },
      scope = { enabled = true },
    },
    -- config = function()
    --   vim.api.nvim_create_autocmd('User', {
    --     pattern = 'MiniFilesActionRename',
    --     callback = function(event)
    --       Snacks.rename.on_rename_file(event.data.from, event.data.to)
    --     end,
    --   })
    -- end,
    keys = {
      {
        '<leader>sq',
        function()
          Snacks.picker.qflist()
        end,
        desc = 'Quickfix',
      },
      {
        '<leader>sl',
        function()
          Snacks.picker.qflist()
        end,
        desc = 'Loclist',
      },
      {
        '<leader>s.',
        function()
          Snacks.picker.recent()
        end,
        desc = 'Recently Closed',
      },
      {
        '<leader><leader>',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = 'Help Pages',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = 'Keymaps',
      },
      {
        '<leader>sn',
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = 'Find Config File',
      },
      {
        '<leader>a',
        function()
          Snacks.picker.smart()
        end,
        desc = 'Files',
      },
      {
        '<leader>sb',
        function()
          Snacks.picker.files { cwd = vim.fn.expand '%:p:h' }
        end,
        desc = 'Search Files buffer dir',
      },
      {
        '<leader>sa',
        function()
          Snacks.picker.files { cwd = vim.fn.getcwd }
        end,
        desc = 'Search Files cwd',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker()
        end,
        desc = 'Pickers',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = 'Visual selection or word',
        mode = { 'n', 'x' },
      },
      {
        '<leader>i',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>so',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = 'Workspace Diagnostics',
      },
      {
        '<leader>sr',
        function()
          Snacks.picker.resume()
        end,
        desc = 'Resume',
      },
      {
        '<leader>/',
        function()
          Snacks.picker.lines()
        end,
        desc = 'Buffer Lines',
      },
      {
        '<leader>;',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      {
        '<leader>:',
        function()
          Snacks.picker.commands()
        end,
        desc = 'Commands',
      },
      {
        '<leader>?',
        function()
          Snacks.picker.search_history()
        end,
        desc = 'Search History',
      },
      {
        "<leader>'",
        function()
          Snacks.picker.marks()
        end,
        desc = 'Marks',
      },
      {
        '<leader>j',
        function()
          Snacks.picker.jumps()
        end,
        desc = 'Jumps',
      },
      {
        '<leader>"',
        function()
          Snacks.picker.registers()
        end,
        desc = 'Registers',
      },
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        '<leader>r',
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = 'References',
      },
      {
        'gI',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'gy',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
      {
        '<leader>dm',
        function()
          Snacks.picker.lsp_symbols { filter = {
            default = {
              'Method',
            },
          } }
        end,
        desc = 'LSP Methods',
      },
      {
        '<leader>ds',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'LSP Symbols',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = 'Buffer diagnostics',
      },
      {
        '<leader>df',
        function()
          Snacks.picker.lsp_symbols { filter = {
            default = {
              'Function',
            },
          } }
        end,
        desc = 'LSP Function',
      },
      {
        '<leader>dc',
        function()
          Snacks.picker.lsp_symbols { filter = {
            default = {
              'Classes',
            },
          } }
        end,
        desc = 'LSP Classes',
      },
    },
  },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git c[h]ange' })

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git c[h]ange' })

        -- Actions
        -- visual mode
        map('v', '<leader>gs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'git [s]tage/unstage hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>gb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>gd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>gD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        map('n', '<leader>gt', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show blame line' })
        map('n', '<leader>gT', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show deleted' })
      end,
    },
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      preset = 'helix',
      spec = {
        { '<leader>c', group = '[C]ode' },
        { '<leader>c_', hidden = true },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>d_', hidden = true },
        { '<leader>g', group = '[G]it\t' },
        { '<leader>g_', hidden = true },
        { '<leader>r', group = '[R]ename' },
        { '<leader>r_', hidden = true },
        { '<leader>s', group = '[S]earch' },
        { '<leader>s_', hidden = true },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>w_', hidden = true },
        { '<leader>g', desc = 'Git [H]unk', mode = 'v' },
        { '<leader>g_', hidden = true },
      },
    },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      labels = 'aeichtnsrkmgpfjldwvuoybxqz',
      modes = { search = { enabled = true }, char = { highlight = { backdrop = false } } },
      search = { mode = 'search' },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
    specs = {
      {
        'folke/snacks.nvim',
        opts = {
          picker = {
            win = {
              input = {
                keys = {
                  ['<a-s>'] = { 'flash', mode = { 'n', 'i' } },
                  ['ß'] = { 'flash', mode = { 'n', 'i' } },
                  ['s'] = { 'flash' },
                },
              },
            },
            actions = {
              flash = function(picker)
                require('flash').jump {
                  pattern = '^',
                  label = { after = { 0, 0 } },
                  search = {
                    mode = 'search',
                    exclude = {
                      function(win)
                        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'snacks_picker_list'
                      end,
                    },
                  },
                  action = function(match)
                    local idx = picker.list:row2idx(match.pos[1])
                    picker.list:_move(idx, true, true)
                  end,
                }
              end,
            },
          },
        },
      },
    },
  },
  {
    'sindrets/diffview.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('diffview').setup {
        view = {
          merge_tool = {
            layout = 'diff4_mixed',
          },
        },
      }
    end,
    keys = {
      {
        '<leader>go',
        mode = { 'n' },
        function()
          vim.cmd 'DiffviewOpen'
        end,
        desc = 'Open diffview',
      },
      {
        '<leader>gf',
        mode = { 'n' },
        function()
          vim.cmd 'DiffviewFileHistory %'
        end,
        desc = 'Diffview file history',
      },
      {
        '<leader>gm',
        mode = { 'n' },
        function()
          vim.cmd 'DiffviewOpen origin/master'
        end,
        desc = 'Diff against [m]aster',
      },
      {
        '<leader>gx',
        mode = { 'n' },
        function()
          vim.cmd 'DiffviewClose'
        end,
        desc = '[x]Close diffview',
      },
    },
  },
  {
    'NeogitOrg/neogit',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function()
      local style = 'kitty'
      if vim.g.neovide then
        style = 'unicode'
      end
      require('neogit').setup {
        graph_style = style,
        integrations = { telescope = false, fzf_lua = false, diffview = true },
        commit_editor = { show_staged_diff = false },
      }
      local neogit = require 'neogit'
      vim.keymap.set('n', '<leader>gc', neogit.action('commit', 'commit', { '--verbose', '--all' }))
    end,
    keys = {
      {
        '<leader>n',
        mode = { 'n' },
        function()
          require('neogit').open {}
        end,
        desc = '[N]eogit',
      },
    },
  },
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, options)
            vim.keymap.set('n', keys, function()
              func(options)
            end, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        elixirls = {},
        pyright = {
          settings = {
            python = {
              analysis = { diagnosticMode = 'openFilesOnly' },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = 'Disable',
                semicolon = 'Disable',
                arrayIndex = 'Disable',
              },
              -- ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      require('mason').setup()
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>h',
        function()
          require('conform').format { async = false, lsp_fallback = false }
          vim.cmd 'w'
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'yapf' },
        json = { 'jq' },
        elixir = { 'mix' },
      },
    },
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          return 'make install_jsregexp'
        end)(),
        dependencies = {},
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      vim.keymap.set('i', '<c-j>', require 'luasnip.extras.select_choice')
      require('luasnip.loaders.from_vscode').lazy_load { paths = './snippets' }

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          expandable_indicator = true,
          fields = { 'abbr', 'kind', 'menu' },
          format = function(entry, vim_item)
            vim_item.kind = vim_item.kind .. ' ' .. entry.source.name
            return vim_item
          end,
        },
        completion = { completeopt = 'menu,menuone,noselect,fuzzy' },

        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp.mapping.confirm(),
          ['<S-Tab>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'path' },
          -- Require at least the first character be typed before showing completion.
          { name = 'buffer', keyword_length = 1 },
        },
      }
      -- Completion for / search.
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })
      -- `:` vim cmdline completion.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' },
            },
          },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.tabline').setup()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.files').setup()
      require('mini.move').setup {
        mappings = {
          -- Move visual selection in Visual mode.
          left = '<C-h>',
          right = '<C-l>',
          down = '<C-j>',
          up = '<C-k>',

          -- Move current line in Normal mode
          line_left = '<C-h>',
          line_right = '<C-l>',
          line_down = '<C-j>',
          line_up = '<C-k>',
        },
      }
      require('mini.surround').setup {
        mappings = {
          add = 'gsa', -- Add surrounding in Normal and Visual modes
          delete = 'gsd', -- Delete surrounding
          find = 'gsf', -- Find surrounding (to the right)
          find_left = 'gsF', -- Find surrounding (to the left)
          highlight = 'gsh', -- Highlight surrounding
          replace = 'gsr', -- Replace surrounding
          update_n_lines = 'gsn', -- Update `n_lines`
        },
      }
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      require('mini.operators').setup {
        -- Replace text with register
        replace = {
          prefix = 'gh',

          -- Whether to reindent new text to match previous indent
          reindent_linewise = true,
        },
        sort = {
          prefix = 'gz',
          func = nil,
        },
      }
      require('mini.bufremove').setup()

      vim.keymap.set('n', '<leader>x', function()
        MiniBufremove.delete()
      end, { desc = 'Workspace delete buffer' })
      vim.keymap.set('n', '<leader>db', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0), nil)
      end, { desc = 'File [B]rowser current files dir' })
      vim.keymap.set('n', '<leader>dr', function()
        MiniFiles.open(nil)
      end, { desc = 'File [B]rowser working directory' })
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
          -- Avoid the sticky context from growing a lot.
          max_lines = 3,
          -- Match the context lines to the source code.
          multiline_threshold = 1,
          -- Disable it when the window is too small.
          min_window_height = 20,
        },
        keys = {
          {
            '[c',
            function()
              -- Jump to previous change when in diffview.
              if vim.wo.diff then
                return '[c'
              else
                vim.schedule(function()
                  require('treesitter-context').go_to_context()
                end)
                return '<Ignore>'
              end
            end,
            desc = 'Jump to upper context',
            expr = true,
          },
        },
      },
    },
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'python', 'proto', 'yaml' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
    init = function()
      -- Enable code folding.
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldenable = false
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
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
