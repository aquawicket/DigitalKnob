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
# dk_DKCACHE_DIR() <set_var>
#
#
function(dk_DKCACHE_DIR)
    dk_debugFunc(0 1)
	
	###### SET ######
	if(ARGV)
		dk_set(DKCACHE_DIR "${ARGV0}")

	###### GET ######
	elseif(DEFINED ENV{DKCACHE_DIR})
		file(TO_CMAKE_PATH "$ENV{DKCACHE_DIR}" DKCACHE_DIR)
	else()
		dk_validate(DKHOME_DIR "dk_DKHOME_DIR()")
		set(DKCACHE_DIR "${DKHOME_DIR}/.dk")
	endif()
	
	###### FINALIZE ######
	if(NOT EXISTS "${DKCACHE_DIR}")
		dk_mkdir("${DKCACHE_DIR}")
	endif()
	dk_assertPath(${DKCACHE_DIR})
	
	dk_set(DKCACHE_DIR "${DKCACHE_DIR}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
	dk_echo()
	dk_echo("Test Getting DKCACHE_DIR . . .")
	dk_DKCACHE_DIR()
	if(EXISTS "${DKCACHE_DIR}")
		dk_success("DKCACHE_DIR = ${DKCACHE_DIR}")
	else()
		dk_error("DKCACHE_DIR:'${DKCACHE_DIR}' NOT FOUND")
	endif()
	
	dk_echo()
	dk_echo("Test Setting DKCACHE_DIR . . .")
	dk_DKCACHE_DIR("C:/.dk")
	if(EXISTS "${DKCACHE_DIR}")
		dk_success("DKCACHE_DIR = ${DKCACHE_DIR}")
	else()
		dk_error("DKCACHE_DIR:'${DKCACHE_DIR}' NOT FOUND")
	endif()
endfunction()
