local M = {}

function M.add_to_decorator(input)
  if input == nil then
    return
  end
  local buf = vim.api.nvim_win_get_buf(0)
  local pos = vim.api.nvim_win_get_cursor(0)
  local parser = vim.treesitter.get_parser(buf)

  local nodes = {}
  do
    parser:for_each_tree(function(tstree, tree)
      if not tstree then
        return
      end
      -- get all ranges of the current node and its parents
      local node = tree:named_node_for_range({ pos[1] - 1, pos[2], pos[1] - 1, pos[2] }, {
        ignore_injections = true,
      })

      while node do
        nodes[#nodes + 1] = node
        node = node:parent() ---@type TSNode
      end
    end)
  end

  local function_node, decorator_node
  for _, node in ipairs(nodes) do
    local node_type = node:type()
    if node_type == 'decorated_definition' then
      decorator_node = node
    elseif node_type == 'function_definition' then
      function_node = node
    end
  end

  if function_node == nil then
    -- wasn't executed inside a function, do nothing
    vim.notify('Was not called inside a function', vim.log.levels.WARN, { title = 'testing.nvim' })
    vim.api.nvim_input '<esc>'
    return
  end
  if decorator_node == nil then
    M.add_full_decorator(buf, function_node, input)
  else
    -- some decorators exist
    local query = vim.treesitter.query.parse(
      'python',
      [[
    (decorator
      (call
        function: (attribute) @name (#eq? @name "asd.decorator")
        arguments: (argument_list) @arguments))
    ]]
    )

    for _, match, _ in query:iter_matches(decorator_node, buf) do
      local row, column, _ = match[2]:end_()
      local last_char = vim.api.nvim_buf_get_text(buf, row, column - 2, row, column - 1, {})[1]
      local new_meas = string.format(' asd.measure(%s),', input)
      if last_char == ')' then
        new_meas = ',' .. new_meas
      end
      vim.api.nvim_buf_set_text(buf, row, column - 1, row, column - 1, { new_meas })
    end
  end
end

function M.add_full_decorator(buf, function_node, name)
  local start = function_node:start()
  local line = { string.format('@lol(%s)', name) }
  vim.api.nvim_buf_set_lines(buf, start, start, false, line)
end

vim.ui.input({ prompt = 'Enter name:' }, M.add_to_decorator)
