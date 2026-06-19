#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


dk_load("${DKCMAKE_FUNCTIONS_DIR_}/dk_watchCallback.cmake")
#########################################################################
# dk_watch(variable)
# 
#	Watch a varible reading and writing access events
#
#	@variable	- The variable to watch
#
macro(dk_watch variable)
	#dk_debugFunc()
	
#	if(DEFINED ${variable})
		variable_watch(${variable} dk_watchCallback)
#	else()
#		dk_warning("variable:${variable} is undefined")
#	endif()
	
endmacro()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_watch(CMAKE_CURRENT_FUNCTION_LIST_FILE)
	#dk_watch(CMAKE_CURRENT_FUNCTION_LIST_LINE)
	#dk_watch(CMAKE_CURRENT_FUNCTION)

endfunction()