-- Picker, finder, etc.
return {
  {
    'ibhagwan/fzf-lua',
    cmd = 'Fzflua',
    keys = {
      { '<leader>sd', '<cmd>FzfLua lsp_document_diagnostics<cr>', desc = 'Document diagnostics' },
      { '<leader>ss', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Document symbols' },
      {
        '<leader>sm',
        function()
          require('fzf-lua').lsp_document_symbols { query = 'Method ' }
        end,
        desc = 'Document methods',
      },
      {
        '<leader>sv',
        function()
          require('fzf-lua').lsp_document_symbols { query = 'Variable ' }
        end,
        desc = 'Document variables',
      },
      {
        '<leader>sC',
        function()
          require('fzf-lua').lsp_document_symbols { query = 'Constant ' }
        end,
        desc = 'Document constants',
      },
      {
        '<leader>sc',
        function()
          require('fzf-lua').lsp_document_symbols { query = 'Class ' }
        end,
        desc = 'Document classes',
      },
      {
        '<leader>sf',
        function()
          require('fzf-lua').lsp_document_symbols { query = 'Fuction ' }
        end,
        desc = 'Document Functions',
      },
      { '<leader>sh', '<cmd>FzfLua search_history<cr>', desc = 'Search history' },
      { '<leader>sH', '<cmd>FzfLua help_tags<cr>', desc = 'Help' },
      { '<leader>sw', '<cmd>FzfLua grep_cword<cr>', desc = 'Search current word' },
      { '<leader>sW', '<cmd>FzfLua grep_cWORD<cr>', desc = 'Search current WORD' },
      { '<leader>G', '<cmd>FzfLua global<cr>', desc = 'Global picker' },
      { '<leader>sa', '<cmd>FzfLua lsp_incoming_calls<cr>', desc = 'Incoming calls' },
      { '<leader>so', '<cmd>FzfLua lsp_outgoing_calls<cr>', desc = 'Outgoing calls' },
      { '<leader>s.', '<cmd>FzfLua oldfiles<cr>', desc = 'All recently opened files' },
      {
        '<leader>a',
        function()
          require('fzf-lua').oldfiles { cwd_only = true }
        end,
        desc = 'cwd recently opened files',
      },
      { '<leader>sB', '<cmd>FzfLua buffers<cr>', desc = 'Buffers' },
      { '<leader>sr', '<cmd>FzfLua resume<cr>', desc = 'Resume last fzf command' },
      { '<leader>e', '<cmd>FzfLua files<cr>', desc = 'Find files' },
      { '<leader>/', '<cmd>FzfLua grep_curbuf<cr>', desc = 'Fuzzy find buffer' },
      { '<leader>s/', '<cmd>FzfLua lgrep_curbuf<cr>', desc = 'Grep buffer' },
      { "<leader>'", '<cmd>FzfLua marks<cr>', desc = 'Marks' },
      { '<leader>"', '<cmd>FzfLua registers<cr>', desc = 'Registers' },
      { '<leader>:', '<cmd>FzfLua commands<cr>', desc = 'Commands' },
      { '<leader>;', '<cmd>FzfLua command_history<cr>', desc = 'Command history' },
      { '<leader>?', '<cmd>FzfLua search_history<cr>', desc = 'Search history' },
      { '<leader>sj', '<cmd>FzfLua jumps<cr>', desc = 'Jumps' },
      { '<leader>su', '<cmd>FzfLua undotree<cr>', desc = 'Undotree' },
      { '<leader>si', '<cmd>FzfLua live_grep_glob<cr>', desc = 'Live grep glob' },
      { '<leader>I', '<cmd>FzfLua live_grep<cr>', desc = 'Live grep project' },
      { '<leader>i', '<cmd>FzfLua grep_project<cr>', desc = 'Fuzzy find project' },
      { '<leader>sG', '<cmd>FzfLua live_grep_resume<cr>', desc = 'Live grep resume' },
      { '<leader>sg', '<cmd>FzfLua grep_last<cr>', desc = 'Grep resume' },
      { '<leader>sQ', '<cmd>FzfLua grep_quickfix<cr>', desc = 'Grep qflist' },
      { '<leader>sq', '<cmd>FzfLua quickfix_stack<cr>', desc = 'Grep qfstack' },
      { '<leader>sl', '<cmd>FzfLua grep_loclist<cr>', desc = 'Grep loclist' },
      { '<leader>sL', '<cmd>FzfLua loclist_stack<cr>', desc = 'Grep locstack' },
      { '<leader>sg', '<cmd>FzfLua grep_visual<cr>', desc = 'Grep', mode = 'x' },
      {
        '<leader>sn',
        function()
          require('fzf-lua').files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = 'Lua config files',
      },
      { 'gd', '<cmd>FzfLua lsp_definitions<cr>', desc = 'Goto LSP Definition' },
      {
        'gD',
        function()
          require('fzf-lua').lsp_definitions { jump1 = false }
        end,
        desc = 'Peek LSP Definition',
      },
      { 'gri', '<cmd>FzfLua lsp_declarations<cr>', desc = 'LSP Declarations' },
      { 'grr', '<cmd>FzfLua lsp_references<cr>', desc = 'LSP References' },
      { 'gO', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Document symbols' },
      { 'grt', '<cmd>FzfLua lsp_typedefs<cr>', desc = 'Type definitions' },
      { 'z=', '<cmd>FzfLua spell_suggest<cr>', desc = 'Spelling suggestions' },
      {
        '<C-x><C-f>',
        function()
          require('fzf-lua').complete_path {
            winopts = {
              height = 0.4,
              width = 0.5,
              relative = 'cursor',
            },
          }
        end,
        desc = 'Fuzzy complete path',
        mode = 'i',
      },
    },
    opts = function()
      local actions = require('fzf-lua').actions

      return {
        { 'ivy' },
        oldfiles = {
          include_current_session = true,
          winopts = {
            preview = { hidden = true },
          },
        },
        actions = {
          files = {
            true,
            -- so I can use option on MacOS, same keys as default alt combo
            ['ß'] = actions.file_sel_to_qf,
            ['Œ'] = actions.file_sel_to_ll,
            ['ˆ'] = actions.toggle_ignore,
            ['˙'] = actions.toggle_hidden,
            ['ƒ'] = actions.toggle_follow,
          },
        },
        keymap = {
          fzf = {
            true,
            -- Select all items and add them to the quickfix list
            ['alt-q'] = 'select-all+accept',
            -- so I can use option on MacOS, same keys as the alt combo
            ['œ'] = 'select-all+accept',
            ['å'] = 'toggle-all',
            ['©'] = 'first',
            ['˝'] = 'last',
          },
        },
      }
    end,
  },
}
