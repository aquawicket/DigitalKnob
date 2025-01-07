#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

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
	dk_debugFunc(0)
	
	dk_todo()
endfunction()