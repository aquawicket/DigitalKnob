include_guard()

macro(dk_dumpAllVariables file)
	#DKDEBUGFUNC(${ARGV})
	
	execute_process(COMMAND ${CMAKE_COMMAND} -E remove ${file})
	get_cmake_property(vars VARIABLES)
	list (SORT vars)
	foreach (var ${vars})
		file(APPEND ${file} "${var}:	${${var}}\n")
	endforeach()
endmacro()
