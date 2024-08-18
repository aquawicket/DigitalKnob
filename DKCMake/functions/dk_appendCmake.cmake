include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_appendCmake(<str>)
#
#	<str>	- TODO
#
function(dk_appendCmake str)
	dk_debugFunc(${ARGV})
	
	dk_fileAppend(${plugin_path}/CMakeLists.txt "${str}")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()

endfunction()