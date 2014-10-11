#!/usr/bin/lua

ltdiff = require "ltdiff"
utils = require "utils"

if #arg ~= 2 then
	return print ("Usage: lua ltpatch.lua <file.lua> <diff.lua>\nApplies a lua table diff file to a lua file.")
end

local file = dofile(arg[1])
local diff = dofile(arg[2])

print ("file: " .. utils.serialize(file))
print ("----")
print ("diff: " .. utils.serialize(diff))
print ("----")
print ("patched = " .. utils.serialize(ltdiff.patch (file, diff)))

