local M = {}

function M.add_to_decorator(input)
  if input == nil then
    return
  end
  local buf = vim.api.nvim_win_get_buf(0)
  local pos = vim.api.nvim_win_get_cursor(0)
  local newline_pos = pos[1]

  local cursor_node = vim.treesitter.get_node()
  local function_node, decorator_node
  local node = cursor_node
  while node do
    local node_type = node:type()
    if node_type == 'decorated_definition' then
      decorator_node = node
    elseif node_type == 'function_definition' then
      function_node = node
    end
    if decorator_node ~= nil then
      break
    end
    node = node:parent() --@type TSNode
  end

  if function_node == nil then
    -- wasn't executed inside a function, do nothing
    vim.notify('Was not called inside a function', vim.log.levels.WARN, { title = 'testing.nvim' })
    vim.api.nvim_input '<esc>'
    return
  end
  if decorator_node == nil then
    M.add_full_decorator(buf, function_node, input)
    newline_pos = newline_pos + 1
  else
    -- some decorators exist
    -- this checks for the measurement already existing
    local query = vim.treesitter.query.parse(
      'python',
      [[
    (decorator
      (call
        function: (attribute) @name (#eq? @name "asd.decorator")
        arguments: (argument_list) @arguments))
    ]]
    )

    local found = false
    for _, match, _ in query:iter_matches(decorator_node, buf) do
      found = true
      local row, column, _ = match[2]:end_()
      local last_char = vim.api.nvim_buf_get_text(buf, row, column - 2, row, column - 1, {})[1]
      local new_meas = string.format("asd.measure('%s'),", input)
      if last_char == ')' then
        new_meas = ', ' .. new_meas
      end
      vim.api.nvim_buf_set_text(buf, row, column - 1, row, column - 1, { new_meas })
    end

    if not found then
      -- add the decorator node
      M.add_full_decorator(buf, function_node, input)
      newline_pos = newline_pos + 1
    end
  end
  -- get indentation level for inserting new text
  local non_blank = vim.api.nvim_get_current_line():match('^%s*'):len()
  vim.api.nvim_buf_set_lines(buf, newline_pos, newline_pos, true, { string.rep(' ', non_blank) .. 'asdfasdf = ' })
  vim.api.nvim_win_set_cursor(0, { newline_pos + 1, 0 })
  vim.cmd 'startinsert!'
end

function M.add_full_decorator(buf, function_node, name)
  local start = function_node:start()
  local line = { string.format('@lol(%s)', name) }
  vim.api.nvim_buf_set_lines(buf, start, start, false, line)
end

vim.ui.input({ prompt = 'Enter name:' }, M.add_to_decorator)
