#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_printAllVariables()
#
#	Print all cmake varibles and save to /cmake_variables.temp 
#
function(dk_printAllVariables)
	dk_debugFunc("\${ARGV}")
	
	get_cmake_property(varNames VARIABLES)
	list(SORT varNames)
	foreach(varName ${varNames})
		dk_debug(varName)
		dk_fileAppend(${CMAKE_BINARY_DIR}/cmake_variables.temp "${varName}				==				${${varName}}\n")
	endforeach()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_printAllVariables()
endfunction()
