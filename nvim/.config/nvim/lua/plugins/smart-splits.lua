return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  keys = {
    {
      '˙',
      mode = { 'n' },
      function()
        require('smart-splits').move_cursor_left()
      end,
      desc = 'Move cursor left split',
    },
    {
      '¬',
      mode = { 'n' },
      function()
        require('smart-splits').move_cursor_right()
      end,
      desc = 'Move cursor right split',
    },
    {
      '˚',
      mode = { 'n' },
      function()
        require('smart-splits').move_cursor_up()
      end,
      desc = 'Move cursor up split',
    },
    {
      '∆',
      mode = { 'n' },
      function()
        require('smart-splits').move_cursor_down()
      end,
      desc = 'Move cursor down split',
    },
  },
}
