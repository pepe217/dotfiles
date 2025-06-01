return {
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
}
