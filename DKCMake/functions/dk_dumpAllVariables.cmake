include(${DKCMAKE_DIR}/functions/DK.cmake)
include_guard()

function(dk_dumpAllVariables file)
	dk_debugFunc(${ARGV})
	
	execute_process(COMMAND ${CMAKE_COMMAND} -E remove ${file})
	get_cmake_property(vars VARIABLES)
	list (SORT vars)
	foreach (var ${vars})
		file(APPEND ${file} "${var}:	${${var}}\n")
	endforeach()
endfunction()
