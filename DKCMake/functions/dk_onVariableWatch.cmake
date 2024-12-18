#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_onVariableWatch()
#
macro(dk_onVariableWatch variable access value current_list_file stack)
	#dk_debugFunc()
	
	if("${access}" STREQUAL "MODIFIED_ACCESS")
		message("dk_onVariableWatch(${variable} ${access} ${value} ${current_list_file} ${stack})")
		dk_stacktrace()
		#dk_messageBox("${variable} = ${value}")
		dk_messageBox("${CMAKE_CURRENT_LIST_FILE}")
	endif()
endmacro()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()

	dk_onVariableWatch(TODO) # todo
endfunction()
