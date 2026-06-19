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


########################################################################
# dk_DKTOOLS_DIR()
#
#
function(dk_DKTOOLS_DIR)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		set(DKTOOLS_DIR "${ARGV0}")

	###### GET ######	
	elseif(DEFINED ENV{DKTOOLS_DIR})
		file(TO_CMAKE_PATH "$ENV{DKTOOLS_DIR}" DKTOOLS_DIR)
		set(DKTOOLS_DIR "${DKTOOLS_DIR}")
	else()
		dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
		set(DKTOOLS_DIR "${DIGITALKNOB_DIR}/DKTools")
	endif()

	###### FINALIZE ######
	if(NOT EXISTS "${DKTOOLS_DIR}") 
		dk_mkdir("${DKTOOLS_DIR}")
	endif()
	dk_assertPath("${DKTOOLS_DIR}")
	
	dk_set(DKTOOLS_DIR "${DKTOOLS_DIR}")
	
#dk_debug("DKTOOLS_DIR = ${DKTOOLS_DIR}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_echo()
	dk_echo("Test Getting DKTOOLS_DIR . . .")
	dk_DKTOOLS_DIR()
	dk_echo("DKTOOLS_DIR = ${DKTOOLS_DIR}")

	dk_echo()
	dk_echo("Test Setting DKTOOLS_DIR . . .")
	dk_DKTOOLS_DIR("C:/DKTools")
	dk_echo("DKTOOLS_DIR = ${DKTOOLS_DIR}")
endfunction()
