return {
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
      'gD',
      function()
        Snacks.picker.lsp_definitions { auto_confirm = false }
      end,
      desc = 'Peek Definition',
    },
    {
      'grr',
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
}
