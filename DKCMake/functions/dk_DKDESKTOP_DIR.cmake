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


####################################################################
# dk_DKDESKTOP_DIR()
#
#
function(dk_DKDESKTOP_DIR)
    dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(DKDESKTOP_DIR "${ARGV0}")

	###### GET ######
	elseif(DEFINED ENV{DKDESKTOP_DIR})	
		file(TO_CMAKE_PATH "$ENV{DKDESKTOP_DIR}" DKDESKTOP_DIR)
	else()
		dk_validate(DKHOME_DIR "dk_DKHOME_DIR()")
		set(DKDESKTOP_DIR "${DKHOME_DIR}/Desktop")
	endif()
	
	###### FINALIZE ######
	#dk_assertPath(${DKDESKTOP_DIR})
	dk_set(DKDESKTOP_DIR "${DKDESKTOP_DIR}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
	dk_echo()
	dk_echo("Test Getting DKDESKTOP_DIR . . .")
	dk_DKDESKTOP_DIR()
	if(EXISTS "${DKDESKTOP_DIR}")
		dk_success("DKDESKTOP_DIR = ${DKDESKTOP_DIR}")
	else()
		dk_error("DKDESKTOP_DIR:'${DKDESKTOP_DIR}' NOT FOUND")
	endif()
	
	dk_echo()
	dk_echo("Test Setting DKDESKTOP_DIR . . .")
	dk_DKDESKTOP_DIR("C:/Desktop")
	if(EXISTS "${DKDESKTOP_DIR}")
		dk_success("DKDESKTOP_DIR = ${DKDESKTOP_DIR}")
	else()
		dk_error("DKDESKTOP_DIR:'${DKDESKTOP_DIR}' NOT FOUND")
	endif()
endfunction()
