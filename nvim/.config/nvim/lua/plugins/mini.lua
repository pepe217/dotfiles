-- Collection of various small independent plugins/modules
return {
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
        add = 'sa', -- Add surrounding in Normal and Visual modes
        delete = 'sd', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`
      },
    }
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    require('mini.operators').setup {
      -- Exchange text regions
      exchange = {
        prefix = 'gX',

        -- Whether to reindent new text to match previous indent
        reindent_linewise = true,
      },
      -- Replace text with register
      replace = {
        prefix = 'gh',

        -- Whether to reindent new text to match previous indent
        reindent_linewise = true,
      },
      sort = {
        prefix = 'gS',
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
}
