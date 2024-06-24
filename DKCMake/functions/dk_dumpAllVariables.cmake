include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

function(dk_dumpAllVariables file)
	dk_debugFunc(${ARGV})
	
	execute_process(COMMAND ${CMAKE_COMMAND} -E remove ${file})
	get_cmake_property(vars VARIABLES)
	list (SORT vars)
	foreach (var ${vars})
		dk_fileAppend(${file} "${var}:	${${var}}\n")
	endforeach()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()