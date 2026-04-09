return {
  'dlyongemallo/diffview.nvim',
  lazy = false,
  config = function()
    require('diffview').setup {
      enhanced_diff_hl = true,
      use_icons = true,
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
      '<leader>gP',
      mode = { 'n' },
      function()
        vim.cmd 'DiffviewOpen origin/HEAD...HEAD --imply-local'
      end,
      desc = 'Open diffview for PR review',
    },
    {
      '<leader>gF',
      mode = { 'n' },
      function()
        vim.cmd 'DiffviewFileHistory'
      end,
      desc = 'Diffview file history',
    },
    {
      '<leader>gf',
      mode = { 'n' },
      function()
        vim.cmd 'DiffviewFileHistory %'
      end,
      desc = 'Diffview current file history',
    },
    {
      '<leader>gM',
      mode = { 'n' },
      function()
        vim.cmd 'DiffviewOpen origin/master'
      end,
      desc = 'Diff against origin [M]aster',
    },
    {
      '<leader>gm',
      mode = { 'n' },
      function()
        vim.cmd 'DiffviewOpen master'
      end,
      desc = 'Diff against [m]aster',
    },
    {
      '<leader>gd',
      mode = { 'n' },
      function()
        vim.cmd 'DiffviewOpen HEAD'
      end,
      desc = 'Diff against HEAD',
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
}
