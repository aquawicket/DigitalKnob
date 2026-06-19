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
# dk_validateFunc(func_name)
#
#	@variable  - The name of a variable to test
#	@code	   - The code to run if the variable is invalid. Like a function "dk_DIGITALKNOB_DIR()"
#
function(dk_validateFunc)# variable code)
	if(NOT COMMAND dk_debugFunc)
		dk_source(dk_debugFunc)
	endif()
	dk_debugFunc(1)
	
	if(NOT COMMAND ${ARGV})
		dk_source(${ARGV})
	endif()
		
	if(NOT COMMAND ${ARGV})
		dk_error("Failed to load ${ARGV}")
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validateFunc(dk_notice)
	if(COMMAND dk_notice)
		message("dk_notice is loaded")
	else()
		message("dk_notice is NOT loaded")
	endif()
	pause()
endfunction()
