local test = require 'custom.plugins.part2'
local fmt = require('luasnip.extras.fmt').fmt
local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local events = require 'luasnip.util.events'

ls.add_snippets('all', {
  s(
    'z',
    fmt("lolol['{}'] = ", {
      i(1, ''),
    }),
    {
      callbacks = {
        [-1] = {
          [events.leave] = function(node)
            local temp = node:get_text()[1]
            local match = string.match(temp, ".+%[%'(.+)%'%].+")
            test.add_to_decorator(match)
          end,
        },
      },
    }
  ),
})
