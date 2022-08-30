local classes = require "utils.classes"

local Queue = classes.class()

function Queue:init()
    self.first = 0
    self.last = -1
    self.items = {}
end

function Queue:count()
  local count = 0
  for _ in pairs(self.items) do count = count + 1 end
  return count
end

function Queue:enqueue(value)
    self.last = self.last + 1
    self.items[self.last] = value
end

function Queue:dequeue()
  if self:count() == 0 then
    return nil
  end

  local first = self.first
  local value = self.items[first]

  self.items[first] = nil        -- to allow garbage collection
  self.first = self.first + 1

  return value
end

function Queue:deleteFirst(value)
  local i = -1
  for k = self.first,self.last,1
  do
    if self.items[k] == value then
      self.items[k] = nil
      i = k
    end
  end

  -- Value not found
  if i == -1 then
    return
  end

  for k = i,self.last,1
  do
    self.items[k] = self.items[k+1]
  end
  self.items[self.last] = nil
  self.last = self.last - 1
end

function Queue:print()
  local res = "Queue: { "
  for k,v in pairs(self.items) do
      res = res..k..": "..v..", "
  end  
  print(res.." }")
end

return Queue