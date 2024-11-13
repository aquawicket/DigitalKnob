#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_appendCmake(<str>)
#
#	<str>	- TODO
#
function(dk_appendCmake str)
	dk_debugFunc()
	
	dk_fileAppend(${plugin_path}/CMakeLists.txt "${str}")
	
# DEBUG
#	TODO
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()
