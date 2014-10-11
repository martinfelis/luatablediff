require 'strict'
ltdiff = require 'ltdiff'
utils = require 'utils'

local this = {
	a = 1.1,
	b = 7.2,
	deeper = {
		s1 = 1.0,
		s2 = 2.0
	},
}

local other = {
	a = 1.4,
	b = 7.2,
	deeper = {
		s1 = 1.0,
		s2 = 2.0,
		new = 9.1
	}
}

local other_copy = utils.deepcopy (other)

local diff = ltdiff.diff (this, other)
print ("this = " .. utils.serialize(this))
print ("other = " .. utils.serialize(other))
print ("diff = " .. utils.serialize(diff))

local patched = ltdiff.patch (this, diff)
print ("patched = " .. utils.serialize(patched))

if utils.deepcompare (other_copy, patched) then
	print ("OK")
else
	print ("ERROR patched != other_copy")
end

