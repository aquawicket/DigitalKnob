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
# dk_DKIMPORTS_DIR()
#
#
function(dk_DKIMPORTS_DIR)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(DKIMPORTS_DIR "${ARGV0}")

	###### GET ######
	elseif(DEFINED ENV{DKIMPORTS_DIR})	
		dk_set(DKIMPORTS_DIR "$ENV{DKIMPORTS_DIR}")
	
	else()
		dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
		dk_set(DKIMPORTS_DIR "${DK3RDPARTY_DIR}/_DKIMPORTS")
	endif()
	
	###### FINALIZE ######
	#dk_assertPath(DKIMPORTS_DIR)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_echo()
	dk_echo("Test Getting DKIMPORTS_DIR . . .")
	dk_DKIMPORTS_DIR()
	if(EXISTS "${DKIMPORTS_DIR}")
		dk_success("DKIMPORTS_DIR = ${DKIMPORTS_DIR}")
	else()
		dk_error("DKIMPORTS_DIR:'${DKIMPORTS_DIR}' not found")
	endif()

	dk_echo()
	dk_echo("Test Setting DKIMPORTS_DIR . . .")
	dk_DKIMPORTS_DIR("C:/DK/DKImports")
	if(EXISTS "${DKIMPORTS_DIR}")
		dk_success("DKIMPORTS_DIR = ${DKIMPORTS_DIR}")
	else()
		dk_error("DKIMPORTS_DIR:'${DKIMPORTS_DIR}' not found")
	endif()
endfunction()
