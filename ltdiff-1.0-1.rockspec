package = "ltdiff"
version = "1.0-1"
source = {
	url = "git://github.com/martinfelis/luatablediff",
}
description = {
	summary = "Diffing and patching for Lua tables",
	detailed = [[
LuaTableDiff is a Lua snippet that allows to create diffs recursively
between two Lua tables. This diff can then again be applied to the
original unmodified table to reconstruct the modified table.

This could be used to reduce the amount of data needed to be transmitted
in order to synchronize two tables. Beware that there is some overhead
especially for nested tables with only few entries.
	]],
	homepage = "https://github.com/martinfelis/luatablediff",
	license = "MIT"
}
dependencies = {
	"lua >= 5.1"
}
build = {
	type = "builtin",
	modules = {
		ltdiff = "ltdiff.lua"
	}
}
