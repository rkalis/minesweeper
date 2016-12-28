-- Copyright (c) 2016-2017 Rosco Kalis
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to
-- deal in the Software without restriction, including without limitation the
-- rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
-- sell copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
-- IN THE SOFTWARE.

local functions = {}

-- Used to filter a table of objects that satisfy a certain condition.
-- Loops through the objects in source and checks whether the object contains
-- the passed key together with the passed value.
-- @Arguments:
--  source - a source table containing objects
--  key    - the key that should be filtered on
--  value  - the value that key should have
-- @Returns:
--  a table containing the objects that satisfy the condition
function functions.filter(source, key, value)
    local results = {}
    local tinsert = table.insert
    for _, object in pairs(source) do
        if type(object) == "table" then
            if object[key] == value then
                tinsert(results, object)
            end
        end
    end
    return results
end

-- Concatenates t2 to t1 and empties t2.
-- @Arguments:
--  t1 - the table that should be concatenated onto
--  t2 - the table that should be concatenated
-- @Returns:
--  void
function functions.concat(t1, t2)
    if not t2 then return end
    if type(t1) ~= "table" or type(t2) ~= "table" then return end
    local tinsert = table.insert
    local tremove = table.remove
    for key, value in pairs(t2) do
        tinsert(t1, value)
        tremove(t2, key)
    end
end

-- Computes the distance between two points using the pythogorean theorem.
-- @Arguments:
--  x1, y1 - the coordinates of the first point
--  x2, y2 - the coordinates of the second point
-- @Returns:
--  the distance between the two points
function functions.distance(x1, y1, x2, y2)
    local a = x1 - x2
    local b = y1 - y2
    return math.sqrt(a^2 + b^2)
end

-- Copies an object
-- Works with recursive tables
-- Preserves metatables
-- Works with tables as keys
-- @Arguments:
--  obj - object to be copied
-- @Returns:
--  copy of the object
function functions.copy(obj)
    if type(obj) ~= "table" then return obj end
    local res = {}
    for key, value in pairs(obj) do
        res[functions.copy(key)] = functions.copy(value)
    end
    setmetatable(res, getmetatable(obj))
    return res
end

-- Checks whether an object is clicked
-- @Arguments:
--  obj - object to be checked, obj should at least have an x and y, and either
--        a size when the object is a square, width and height if it is a
--        rectangle or a radius if it is a square
--  x   - x coordinate of the mouse
--  y   - y coordinate of the mouse
-- @Returns:
--  true if the object is clicked, false if not
function functions.is_clicked(obj, x, y)
    local width, height, radius

    -- Getting object properties
    if type(obj) ~= "table" then return false end
    if not obj.x or not obj.y then return false end
    if obj.size then width = obj.size; height = obj.size end
    if obj.width and obj.height then width = obj.width; height = obj.height end
    if obj.radius then radius = obj.radius end

    if radius then
        return functions.distance(x, y, obj.x, obj.y) < radius
    elseif width and height then
        if  x > obj.x and x < obj.x + width
        and y > obj.y and y < obj.y + height then
            return true
        end
    end
    return false
end

-- Inverts a table, swapping all keys and values
-- @Arguments:
--  table - table to be inverted
-- @Returns:
--  inverted table
function functions.table_invert(table)
  local invert = {}
  for key, value in pairs(table) do
      invert[value] = key end
  return invert
end

-- Zero-based ipairs
-- @Arguments
--  t - table to iterate over
-- @Returns
--  iterator over all entries in t with numeric keys of 0 or higher
function functions.ipairs(t)
  local function ipairs_it(t, i)
    i = i + 1
    local v = t[i]
    if v ~= nil then
      return i, v
    else
      return nil
    end
  end
  return ipairs_it, t, -1
end

-- Returns a slice of the specified table
-- @Arguments
--  table - table to slice
--  first - first element of the slice (default 1)
--  last  - last element of the slice (default #table)
--  step  - step size to use when slicing (default 1)
-- @Returns
--  sliced table
function functions.slice(table, first, last, step)
  local sliced = {}
  for i = first or 1, last or #table, step or 1 do
    sliced[#sliced + 1] = table[i]
  end
  return sliced
end

-- Returns all entries returned by an iterator. Only works with iterators that
-- return single values
-- @Arguments
--  ... - iterator call
-- @Returns
--  table with iterator contents
function functions.iter_all(...)
    local table = {}
    for value in ... do
      table[#table + 1] = value
    end
    return table
end

return functions
