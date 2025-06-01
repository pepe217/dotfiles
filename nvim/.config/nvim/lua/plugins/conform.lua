-- Autoformat
return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>h',
      function()
        require('conform').format { async = false, lsp_fallback = false }
        vim.cmd 'w'
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'yapf' },
      json = { 'jq' },
      elixir = { 'mix' },
    },
  },
}
