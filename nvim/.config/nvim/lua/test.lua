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
    local type = node:type()
    if type == 'decorated_definition' then
      decorator_node = node
    elseif type == 'function_definition' then
      function_node = node
    end
  end

  if decorator_node ~= nil then
    if function_node == nil then
      -- wasn't executed inside a function, do nothing
      return
    else
      -- need to add the entire decorator and measurement
      local range = { function_node:range() }
      local line = { string.format('@lol(%s)', input) }
      vim.api.nvim_buf_set_lines(buf, range[1], range[1], false, line)
      return
    end
  else
    -- some decorators exist, try to find an existing add
    return
  end
end

vim.ui.input({ prompt = 'Enter name:' }, M.add_to_decorator)
