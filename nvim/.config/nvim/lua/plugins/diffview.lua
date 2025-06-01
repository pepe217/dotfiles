return {
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
}
