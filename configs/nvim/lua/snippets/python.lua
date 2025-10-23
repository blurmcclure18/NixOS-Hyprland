local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local counter_file = vim.fn.stdpath 'config' .. '/contract_counter.txt'

local function read_counter()
  local file = io.open(counter_file, 'r')
  if file then
    local num = tonumber(file:read '*l')
    file:close()
    if num then
      return num
    end
  end
  return 10
end

local function write_counter(num)
  local file = io.open(counter_file, 'w')
  if file then
    file:write(tostring(num))
    file:close()
  end
end

_G.contract_counter = read_counter()

ls.add_snippets('python', {
  s('contract', {
    f(function()
      _G.contract_counter = _G.contract_counter + 1
      write_counter(_G.contract_counter)
      return 'hur_Contract_' .. _G.contract_counter
    end),
    t {
      ' = Contract(',
      '    contract_Origin=',
    },
    i(1, 'hurston'),
    t { ',', '    contract_Rank=' },
    i(2, 'junior'),
    t { ',', '    contract_Type=' },
    i(3, ''),
    t { ',', '    contract_Size=' },
    i(4, 'medium'),
    t { ',', '    from_Location=' },
    i(5, ''),
    t { ',', '    deliveries=[' },
    t '(',
    i(6, 'amount'),
    t ', ',
    i(7, 'item'),
    t ', ',
    i(8, 'destination'),
    t ')',
    t { ',', '    ],', '    max_Container=' },
    i(9, '8'),
    t { ',', '    contract_Pay=' },
    i(10, ''),
    t ')',
  }),
})
