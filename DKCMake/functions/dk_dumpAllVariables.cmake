#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

############################################################################
# dk_dumpAllVariables(file)
#
function(dk_dumpAllVariables file)
	dk_debugFunc()
	
	execute_process(COMMAND ${CMAKE_COMMAND} -E remove ${file})
	get_cmake_property(vars VARIABLES)
	list (SORT vars)
	foreach (var ${vars})
		dk_fileAppend(${file} "${var}:	${${var}}\n")
	endforeach()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()