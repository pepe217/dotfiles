local fzf = require('fzf-lua')

local M = {}

function M.testing()
  local opts = {}
  opts.prompt = "the prompt"
  opts.actions = {
    ['default'] = function (selected)
      for index, value in ipairs(selected) do
        print(index, value)
      end
    end
  }

  fzf.fzf_exec({'1', '2', '3', '4'}, opts)
end

M.testing()
