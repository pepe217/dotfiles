return {
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
}
