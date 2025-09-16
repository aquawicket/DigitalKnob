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
# dk_title(string)
#
#	Set the title of the console window
#
function(dk_title)
    dk_debugFunc(0 99)
 
	###### method_1: cmd direct #######
	dk_validate(cmd_exe "dk_depend(cmd)")

	if(EXISTS "${cmd_exe}")
		execute_process(COMMAND ${cmd_exe} /c title ${ARGV})
	endif()
	
	###### method_2: dk_callDKBatch ######
	# dk_callDKBatch(dk_title ${ARGV})
endfunction()











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)

    dk_title("------------DKCMake: dk_title TEST 1 ..............")
    dk_title("------------DKCMake: dk_title TEST 2 ..............")
	dk_title("------------DKCMake: dk_title TEST 3 ..............")
endfunction()
