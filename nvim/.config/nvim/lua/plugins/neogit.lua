return {
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
      integrations = { telescope = false, fzf_lua = true, diffview = true },
      commit_editor = { show_staged_diff = false },
    }
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
}
