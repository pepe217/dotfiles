local flash_on_picker = function(picker)
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
      -- auto confirm the selection
      picker:action 'confirm'
    end,
  }
end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      enabled = true,
      actions = {
        flash = function()
          flash_on_picker()
        end,
      },
      win = {
        input = {
          keys = {
            ['<a-s>'] = { 'flash', mode = { 'n', 'i' } },
            ['ß'] = { 'flash', mode = { 'n', 'i' } },
            ['s'] = { 'flash' },
          },
        },
      },
    },
    words = { enabled = true },
    indent = { enabled = true },
    scope = { enabled = true },
  },
  config = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionRename',
      callback = function(event)
        Snacks.rename.on_rename_file(event.data.from, event.data.to)
      end,
    })
  end,
  keys = {
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>S',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
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
        Snacks.picker.buffers {
          on_show = function(picker)
            vim.cmd.stopinsert()

            vim.schedule(function()
              flash_on_picker(picker)
            end)
          end,
        }
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
        Snacks.picker.files { cwd = vim.fn.stdpath 'config', layout = { preview = false } }
      end,
      desc = 'Find Config File',
    },
    {
      '<leader>a',
      function()
        Snacks.picker.smart { layout = { preview = false } }
      end,
      desc = 'Files',
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.files { cwd = vim.fn.expand '%:p:h', { layout = { preset = 'bottom' } }, layout = { preview = false } }
      end,
      desc = 'Search Files buffer dir',
    },
    {
      '<leader>sa',
      function()
        Snacks.picker.files { { layout = { preset = 'bottom' } }, layout = { preview = false } }
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
        Snacks.picker.grep_word { layout = { preset = 'bottom' } }
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },
    {
      '<leader>i',
      function()
        Snacks.picker.grep { layout = { preset = 'bottom' } }
      end,
      desc = 'Grep',
    },
    {
      '<leader>so',
      function()
        Snacks.picker.diagnostics { layout = { preset = 'bottom' } }
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
        Snacks.picker.command_history { layout = { preset = 'bottom' } }
      end,
      desc = 'Command History',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.commands { layout = { preset = 'bottom' } }
      end,
      desc = 'Commands',
    },
    {
      '<leader>?',
      function()
        Snacks.picker.search_history { layout = { preset = 'bottom' } }
      end,
      desc = 'Search History',
    },
    {
      "<leader>'",
      function()
        Snacks.picker.marks { layout = { preset = 'bottom' } }
      end,
      desc = 'Marks',
    },
    {
      '<leader>j',
      function()
        Snacks.picker.jumps { layout = { preset = 'bottom' } }
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
        Snacks.picker.lsp_references { layout = { preset = 'bottom' } }
      end,
      nowait = true,
      desc = 'References',
    },
    {
      'gri',
      function()
        Snacks.picker.lsp_implementations { layout = { preset = 'bottom' } }
      end,
      desc = 'Goto Implementation',
    },
    {
      'gy',
      function()
        Snacks.picker.lsp_type_definitions { layout = { preset = 'bottom' } }
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
        Snacks.picker.diagnostics_buffer { layout = { preset = 'bottom' } }
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
            'Class',
          },
        }, { layout = { preset = 'bottom' } } }
      end,
      desc = 'LSP Classes',
    },
    {
      '<leader>e',
      function()
        Snacks.terminal.toggle()
      end,
      desc = 'Toggle terminal',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undo',
    },
  },
}
