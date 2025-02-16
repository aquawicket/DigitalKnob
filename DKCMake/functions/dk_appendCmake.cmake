#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_appendCmake(<str>)
#
#	<str>	- TODO
#
function(dk_appendCmake)
	dk_debugFunc(1)
	set(str ${ARGV})
	
	dk_assertPath(plugin_path)
	dk_fileAppend(${plugin_path}/CMakeLists.txt "${str}")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_appendCmake(todo) # TODO
endfunction()
