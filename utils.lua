-- utils.lua
local utils = {} -- public interface

function utils.deepcompare(t1,t2,ignore_mt)
	local ty1 = type(t1)
	local ty2 = type(t2)
	if ty1 ~= ty2 then return false end
	-- non-table types can be directly compared
	if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
	-- as well as tables which have the metamethod __eq
	local mt = getmetatable(t1)
	if not ignore_mt and mt and mt.__eq then return t1 == t2 end
	for k1,v1 in pairs(t1) do
		local v2 = t2[k1]
		if v2 == nil or not utils.deepcompare(v1,v2) then return false end
	end
	for k2,v2 in pairs(t2) do
		local v1 = t1[k2]
		if v1 == nil or not utils.deepcompare(v1,v2) then return false end
	end
	return true
end

function utils.deepcopy(t)
	if type(t) ~= 'table' then return t end
	local mt = getmetatable(t)
	local res = {}
	for k,v in pairs(t) do
		if type(v) == 'table' then
			v = utils.deepcopy(v)
		end
		res[k] = v
	end
	setmetatable(res,mt)
	return res
end

function utils.islist(t)
	local itemcount = 0
	local last_type = nil
	for k,v in pairs(t) do
		itemcount = itemcount + 1
		if last_type == nil then
			last_type = type(v)
		end

		if type(v) ~= last_type or (type(v) ~= "string" and type(v) ~= "number" and type(v) ~= "boolean") then
			return false
		end
	
		last_type = type(v)
	end

	if itemcount ~= #t then
		return false
	end

	return true
end

local function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert( orderedIndex, key )
    end
    table.sort( orderedIndex )
    return orderedIndex
end

local function orderedNext(t, state)
    -- Equivalent of the next function, but returns the keys in the alphabetic
    -- order. We use a temporary ordered key table that is stored in the
    -- table being iterated.

		local key = nil
    
		--print("orderedNext: state = "..tostring(state) )
    if state == nil then
        -- the first time, generate the index
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
        return key, t[key]
    end
    -- fetch the next value
    key = nil
    for i = 1,table.getn(t.__orderedIndex) do
        if t.__orderedIndex[i] == state then
            key = t.__orderedIndex[i+1]
        end
    end

    if key then
        return key, t[key]
    end

    -- no more value to return, cleanup
    t.__orderedIndex = nil
    return
end

function utils.orderedPairs(t)
    -- Equivalent of the pairs() function on tables. Allows to iterate
    -- in order
    return orderedNext, t, nil
end

function utils.serialize (o, tabs)
  local result = ""
  
  if tabs == nil then
    tabs = ""
  end

  if type(o) == "number" then
    result = result .. tostring(o)
  elseif type(o) == "boolean" then
    result = result .. tostring(o)
  elseif type(o) == "string" then
    result = result .. string.format("%q", o)
	elseif type(o) == "table" and utils.islist(o) then
		result = result .. " {"
		for i,v in ipairs(o) do
			result = result .. " " .. tostring(v) .. ","
		end
		result = result .. "}"
  elseif type(o) == "table" then
    if o.dont_serialize_me then
      return "{}"
    end
    result = result .. "{\n"
		local last_number_index = 0
    for k,v in utils.orderedPairs(o) do
      if type(v) ~= "function" then
        -- make sure that numbered keys are properly are indexified
        if type(k) == "number" then
					for i=last_number_index + 1,k - 1 do
	          result = result .. tabs .. "  nil, -- " .. tostring(i) .. "\n"
					end
					if (type(v) == "number" or type(v) == "string") then
	          result = result .. tabs .. "  " .. tostring(v) .. ", -- " .. tostring(k) .. "\n"
					else
	          result = result .. tabs .. "  " .. utils.serialize(v, tabs .. "  ") .. ",\n"
					end
					last_number_index = k
--					error ("Error: serialization of arrays with holes not supported!")
        else
          result = result .. tabs .. "  " .. k .. " = " .. utils.serialize(v, tabs .. "  ") .. ",\n"
        end
      end
    end
    result = result .. tabs .. "}"
  else
    print ("ignoring stuff" .. type(o) )
  end
  return result
end


return utils
