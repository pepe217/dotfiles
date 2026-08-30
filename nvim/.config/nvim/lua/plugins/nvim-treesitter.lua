-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-context',
      opts = {
        -- Avoid the sticky context from growing a lot.
        max_lines = 3,
        -- Match the context lines to the source code.
        multiline_threshold = 1,
        -- Disable it when the window is too small.
        min_window_height = 20,
      },
      keys = {
        {
          '[c',
          function()
            -- Jump to previous change when in diffview.
            if vim.wo.diff then
              return '[c'
            else
              vim.schedule(function()
                require('treesitter-context').go_to_context()
              end)
              return '<Ignore>'
            end
          end,
          desc = 'Jump to upper context',
          expr = true,
        },
      },
    },
  },
  build = ':TSUpdate',
  config = function(_, opts)
    local languages = {
      'bash',
      'c',
      'cpp',
      'diff',
      'gitcommit',
      'go',
      'html',
      'json',
      'json5',
      'lua',
      'markdown',
      'markdown_inline',
      'proto',
      'python',
      'query',
      'rasi',
      'regex',
      'rust',
      'toml',
      'vim',
      'vimdoc',
      'yaml',
    }

    require('nvim-treesitter').setup(opts)

    -- Make sure that the following are installed:
    require('nvim-treesitter').install(languages)

    -- Treesitter features for installed languages must be enabled manually
    vim.api.nvim_create_autocmd('FileType', {
      pattern = languages,
      callback = function()
        -- Enable native Neovim treesitter highlighting
        vim.treesitter.start()

        -- Configure code folding
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo.foldmethod = 'expr'
        vim.wo.foldlevel = 99

        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
