#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_appendCmake(<str>)
#
#	<str>	- TODO
#
<<<<<<< HEAD
function(dk_appendCmake str)
	dk_debugFunc()
	
	dk_fileAppend(${plugin_path}/CMakeLists.txt "${str}")
	
# DEBUG
#	TODO
=======
function(dk_appendCmake)
	dk_debugFunc(1)
	set(str ${ARGV})
	
	dk_assertPath(plugin_path)
	dk_fileAppend(${plugin_path}/CMakeLists.txt "${str}")
>>>>>>> Development
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_appendCmake(todo) # TODO
>>>>>>> Development
endfunction()
