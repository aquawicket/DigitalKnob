include_guard()

###############################################################################
# dk_printAllVariables()
#
#	Print all cmake varibles and save to /cmake_variables.temp 
#
macro(dk_printAllVariables)
	DKDEBUGFUNC(${ARGV})
	get_cmake_property(varNames VARIABLES)
	list(SORT varNames)
	foreach(varName ${varNames})
		dk_debug(varName	PRINTVAR)
		file(APPEND ${CMAKE_BINARY_DIR}/cmake_variables.temp "${varName}				==				${${varName}}\n")
	endforeach()
endmacro()
