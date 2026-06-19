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


#########################################################################
# dk_onVariableWatch()
#
macro(dk_onVariableWatch variable access value current_list_file stack)
	#dk_debugFunc()
	
	if("${access}" STREQUAL "MODIFIED_ACCESS")
		dk_echo("dk_onVariableWatch(${variable} ${access} ${value} ${current_list_file} ${stack})")
		dk_stacktrace()
		dk_messageBox("\
		variable = ${variable}\n \
		access   = ${access}\n \
		value    = ${value}\n \
		current_list_file = ${current_list_file}\n \
		stack = ${stack}\n \
		")
		dk_pause()
		
	endif()
endmacro()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()

	dk_onVariableWatch(TODO) # todo
endfunction()
