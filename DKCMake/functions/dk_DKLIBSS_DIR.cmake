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
# dk_DKLIBS_DIR()
#
#
function(dk_DKLIBS_DIR)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(DKLIBS_DIR "${ARGV0}")

	###### GET ######	
	elseif(DEFINED ENV{DKLIBS_DIR})
		file(TO_CMAKE_PATH "$ENV{DKLIBS_DIR}" DKLIBS_DIR)
	else()
		dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
		set(DKLIBS_DIR "${DIGITALKNOB_DIR}/DKLibs")
	endif()

	###### FINALIZE ######
	if(NOT EXISTS "${DKLIBS_DIR}") 
		dk_mkdir("${DKLIBS_DIR}")
	endif()
	dk_assertPath("${DKLIBS_DIR}")
	
	dk_set(DKLIBS_DIR "${DKLIBS_DIR}")
#dk_debug("DKLIBS_DIR = ${DKLIBS_DIR}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_echo()
	dk_echo("Test Getting DKLIBS_DIR . . .")
	dk_DKLIBS_DIR()
	dk_echo("DKLIBS_DIR = ${DKLIBS_DIR}")

	dk_echo()
	dk_echo("Test Setting DKLIBS_DIR . . .")
	dk_DKLIBS_DIR("C:/DKLIBS")
	dk_echo("DKLIBS_DIR = ${DKLIBS_DIR}")
endfunction()
