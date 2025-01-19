local function renamer()
  local old = vim.fn.expand '<cword>'
  local pos = vim.fn.getcurpos(0)
  vim.ui.input({ prompt = 'Rename: ', default = old }, function(new)
    if new then
      vim.fn.setline(pos[2], vim.fn.substitute(vim.fn.getline '.', string.format("'%s'", old), string.format("'%s'", new), ''))
      local m_line = vim.fn.search(string.format("'%s'", old), 'b', '', '', '')
      vim.fn.setline(m_line, vim.fn.substitute(vim.fn.getline '.', string.format("'%s'", old), string.format("'%s'", new), ''))
      vim.fn.cursor { pos[2], pos[3] }
    end
  end)
end
