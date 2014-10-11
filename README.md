# LuaTableDiff

LuaTableDiff is a Lua snippet that allows to create diffs recursively
between two Lua tables. This diff can then again be applied to the
original unmodified table to reconstruct the modified table.

This could be used to reduce the amount of data needed to be transmitted
in order to synchronize two tables. Beware that there is some overhead
especially for nested tables with only few entries.

It provides two functions:

    ltdiff = require "ltdiff"
    diff = ltdiff.diff (old_table, new_table)

This function creates the diff and returns it.

    ltdiff = require "ltdiff"
		new_table = ltdiff.patch (old_table, diff)

Modifies old\_table by applying the diff. This function directly modifies old\_table!

# Example
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

The diff table in this case would look something like this:

    diff = {
      sub = {
        deeper = {
          mod = {
            new = 9.1,
          },
        },
      },
      mod = {
        a = 1.4,
      },
    }

# License

Copyright © 2012-2014 Martin Felis <martin@fysx.org>

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

