include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_appendCmake(<str>)
#
#	<str>	- TODO
#
function(dk_appendCmake str)
	dk_debugFunc(${ARGV})
	
	file(APPEND ${plugin_path}/CMakeLists.txt "${str}")
endfunction()







function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	#dk_todo()

endfunction()