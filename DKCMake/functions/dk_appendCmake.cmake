include_guard()

###############################################################################
# dk_appendCmake(str)
#
#	TODO
#
#	@str	- TODO
#
function(dk_appendCmake str)
	dk_debugFunc(${ARGV})
	
	file(APPEND ${plugin_path}/CMakeLists.txt "${str}")
endfunction()