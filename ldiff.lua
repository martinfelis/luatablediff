#!/usr/bin/lua

ltdiff = require "ltdiff"
utils = require "utils"

if #arg ~= 2 then
	return print ("Usage: lua ltdiff.lua <file1.lua> <file2.lua>\nCompares and prints a diff of two lua tables.")
end

local file1 = dofile(arg[1])
local file2 = dofile(arg[2])

print ("return " .. utils.serialize(ltdiff.diff (file1, file2)))
