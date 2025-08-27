#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################

#########################################################################
# dk_onVariableWatch()
#
macro(dk_onVariableWatch variable access value current_list_file stack)
	#dk_debugFunc()
	
#	#READ_ACCESS, UNKNOWN_READ_ACCESS, MODIFIED_ACCESS, UNKNOWN_MODIFIED_ACCESS, or REMOVED_ACCESS
#	if("${access}" STREQUAL "READ_ACCESS")
#		message("
#			#dk_stacktrace()
#			dk_messageBox("\
#			variable = ${variable}\n \
#			access   = ${access}\n \
#			value    = ${value}\n \
#			current_list_file = ${current_list_file}\n \
#			stack = ${stack}\n \
#		")
#	endif()

	if(("${access}" STREQUAL "MODIFIED_ACCESS") OR ("${access}" STREQUAL "REMOVED_ACCESS"))
		set(DKSTACK "${stack}")
		list(LENGTH DKSTACK stack_length)
		get_filename_component(file ${current_list_file} NAME)
		message("${stack_length}:${file}  ${value}")
	endif()
	
	#if("${access}" STREQUAL "MODIFIED_ACCESS")
	#	message("stored_length = ${stored_length}")
	#endif()
	
	#if("${access}" STREQUAL "REMOVED_ACCESS")
	#	message("stored_length = ${stored_length}")
	#endif()
	
endmacro()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()

	dk_onVariableWatch(TODO) # todo
endfunction()
