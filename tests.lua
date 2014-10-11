require 'strict'
ltdiff = require 'ltdiff'
utils = require 'utils'

function test_table_equal()
	local this = {
		a = 1.1,
		b = 7.2,
		c = "hiho"
	}

	local other = {
		a = 1.1,
		b = 7.2,
		c = "hiho"
	}

	local other_copy = utils.deepcopy (other)

	local diff = ltdiff.diff(this, other)
	local patched = ltdiff.patch(this, diff)

	if utils.deepcompare (other_copy, patched) then
		return "OK"
	else
		return ("ERROR patched != other_copy")
	end
end

function test_table_different()
	local this = {
		a = 1.1,
		b = 7.2,
		c = "hiho"
	}

	local other = {
		o1 = 1.1,
		o2 = 7.2,
		o3 = "hiho",
		o6 = "hiho"
	}

	local other_copy = utils.deepcopy (other)

	local diff = ltdiff.diff(this, other)
	local patched = ltdiff.patch(this, diff)

	if utils.deepcompare (other_copy, patched) then
		return "OK"
	else
		return ("ERROR patched != other_copy")
	end
end

function test_subtable_modified()
	local this = {
		a = 1.1,
		b = 7.2,
		sub = {
			s1 = 1.0,
			s2 = 2.0
		},
	}

	local other = {
		a = 1.4,
		c = 9.9,
		sub = {
			s1 = 2.3,
			s3 = 9.1
		}
	}

	local other_copy = utils.deepcopy (other)

	local diff = ltdiff.diff(this, other)
	local patched = ltdiff.patch(this, diff)

	if utils.deepcompare (other_copy, patched) then
		return "OK"
	else
		return ("ERROR patched != other_copy")
	end
end

function test_subsubtable_deleted()
	local this = {
		a = 1.1,
		b = 7.2,
		sub = {
			s1 = 1.0,
			s2 = 2.0
		},
		deepsub = {
			d1 = 92,
			d2 = 93,
			ddeepsub = {
				dd1 = 22,
				dd2 = 23
			}
		}
	}

	local other = {
		a = 1.4,
		c = 9.9,
		sub = {
			s1 = 2.3,
			s3 = 9.1
		}
	}

	local other_copy = utils.deepcopy (other)

	local diff = ltdiff.diff(this, other)
	local patched = ltdiff.patch(this, diff)

	if utils.deepcompare (other_copy, patched) then
		return "OK"
	else
		return ("ERROR patched != other_copy")
	end
end

function test_subsubtable_modified()
	local this = {
		sub = {
			s1 = 92,
			deepsub = {
				d1 = 22,
				d2 = 23
			}
		}
	}

	local other = {
		sub = {
			s1 = 92,
			deepsub = {
				d1 = 22,
				d2 = 24
			}
		}
	}

	local other_copy = utils.deepcopy (other)

	local diff = ltdiff.diff(this, other)
	local patched = ltdiff.patch(this, diff)

	if utils.deepcompare (other_copy, patched) then
		return "OK"
	else
		return ("ERROR patched != other_copy")
	end
end

function test_subsubsubtable_deleted()
	local this = {
		sub = {
			s1 = 92,
			deepsub = {
				d1 = 22,
				d2 = 23,
				crazydeep = {
					c = 7
				}
			}
		}
	}

	local other = {
		sub = {
			s1 = 92,
			deepsub = {
				d1 = 22,
				d2 = 24
			}
		}
	}

	local other_copy = utils.deepcopy (other)

	local diff = ltdiff.diff(this, other)
	local patched = ltdiff.patch(this, diff)

	if utils.deepcompare (other_copy, patched) then
		return "OK"
	else
		return ("ERROR patched != other_copy")
	end
end

function test_subsubsubtable_modified()
	local this = {
		sub = {
			s1 = 92,
			deepsub = {
				d1 = 22,
				d2 = 23,
				crazydeep = {
					c = 7
				}
			}
		}
	}

	local other = {
		sub = {
			s1 = 92,
			deepsub = {
				d1 = 22,
				d2 = 24,
				crazydeep = {
					c1 = 9,
					c2 = 11
				}
			}
		}
	}

	local other_copy = utils.deepcopy (other)

	local diff = ltdiff.diff(this, other)
	local patched = ltdiff.patch(this, diff)

	if utils.deepcompare (other_copy, patched) then
		return "OK"
	else
		return ("ERROR patched != other_copy")
	end
end

function test_subsubsubtable_added()
	local this = {
		sub = {
			s1 = 92,
		}
	}

	local other = {
		sub = {
			s1 = 92,
			deepsub = {
				d1 = 22,
				d2 = 24,
				crazydeep = {
					c1 = 9,
					c2 = 11
				}
			}
		}
	}

	local other_copy = utils.deepcopy (other)

	local diff = ltdiff.diff(this, other)
	local patched = ltdiff.patch(this, diff)

	if utils.deepcompare (other_copy, patched) then
		return "OK"
	else
		return ("ERROR patched != other_copy")
	end
end

function test_longer_table_modified()
	local this = {
		a = 1.1,
		b = 1.1,
		c = 1.1,
		d = 1.1,
		e = 1.1,
		f = 1.1,
		g = 1.1,
		h = 1.1,
		i = 1.1,
		j = 1.1,
		k = 1.1,
		l = 1.1,
		m = 1.1,
		n = 1.1,
		sub = {
			s1 = 1.0,
			s2 = 2.0
		},
	}

	local other = {
		a = 1.1,
		b = 9.1,
		c = 1.1,
		d = 1.1,
		e = 9.1,
		f = 1.1,
		g = 1.1,
		h = 9.1,
		i = 1.1,
		j = 1.1,
		k = 9.1,
		l = 1.1,
		m = 1.1,
		n = 1.1,
		sub = {
			s1 = 3.0,
			s2 = 7.0
		},
	}

	local other_copy = utils.deepcopy (other)

	local diff = ltdiff.diff(this, other)
	local patched = ltdiff.patch(this, diff)

	if utils.deepcompare (other_copy, patched) then
		return "OK"
	else
		return ("ERROR patched != other_copy")
	end
end

function test_subtable_equal ()
	local this = {
		subtable = {
			s1 = 1.0,
			s2 = 2.0
		},
	}

	local other = {
		subtable = {
			s1 = 1.0,
			s2 = 2.0
		},
	}

	local other_copy = utils.deepcopy (other)
	local diff = ltdiff.diff(this, other)
	local patched = ltdiff.patch(this, diff)

	if next(diff) ~= nil then
		return ("ERROR diff should be an empty table!")
	end

	if utils.deepcompare (other_copy, patched) then
		return "OK"
	else
		return ("ERROR patched != other_copy")
	end
end

print ("TEST 'test_table_equal': " .. test_table_equal())
print ("TEST 'test_table_different': " .. test_table_different())
print ("TEST 'test_subtable_modified': " .. test_subtable_modified())
print ("TEST 'test_subtable_equal': " .. test_subtable_equal())
print ("TEST 'test_subsubtable_deleted': " .. test_subsubtable_deleted())
print ("TEST 'test_subsubtable_modified': " .. test_subsubtable_modified())
print ("TEST 'test_subsubsubtable_deleted': " .. test_subsubsubtable_deleted())
print ("TEST 'test_subsubsubtable_modified': " .. test_subsubsubtable_modified())
print ("TEST 'test_subsubsubtable_added': " .. test_subsubsubtable_added())
print ("TEST 'test_longer_table_modified': " .. test_longer_table_modified())

