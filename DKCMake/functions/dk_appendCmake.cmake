include_guard()

###############################################################################
# dk_appendCmake(str)
#
#	TODO
#
#	@str	- TODO
#
function(dk_appendCmake str)
	DKDEBUGFUNC(${ARGV})
	file(APPEND ${plugin_path}/CMakeLists.txt "${str}")
endfunction()