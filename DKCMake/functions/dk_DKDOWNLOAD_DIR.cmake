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
# dk_DKDOWNLOAD_DIR()
#
#
function(dk_DKDOWNLOAD_DIR)
    dk_debugFunc(0 1)
            
	###### SET ######
	if(ARGV)
		dk_set(DKDOWNLOAD_DIR "${ARGV0}")

	###### GET ######
	elseif(DEFINED ENV{DKDOWNLOAD_DIR})
		file(TO_CMAKE_PATH "$ENV{DKDOWNLOAD_DIR}" DKDOWNLOAD_DIR)
	else()
		dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
		set(DKDOWNLOAD_DIR "${DIGITALKNOB_DIR}/download")
	endif()
	
	###### FINALIZE ######
	if(NOT EXISTS "${DKDOWNLOAD_DIR}") 
		dk_mkdir("${DKDOWNLOAD_DIR}")
	endif()
	dk_assertPath("${DKDOWNLOAD_DIR}")

	dk_set(DKDOWNLOAD_DIR "${DKDOWNLOAD_DIR}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
   
	dk_echo()
	dk_echo("Test Getting DKDOWNLOAD_DIR . . .")
	dk_DKDOWNLOAD_DIR()
	if(EXISTS "${DKDOWNLOAD_DIR}")
		dk_success("DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR}")
	else()
		dk_error("DKDOWNLOAD_DIR:'${DKDOWNLOAD_DIR}' NOT FOUND")
	endif()
	
	dk_echo()
	dk_echo("Test Setting DKDOWNLOAD_DIR . . .")
	dk_DKDOWNLOAD_DIR("C:/DK/download")
	if(EXISTS "${DKDOWNLOAD_DIR}")
		dk_success("DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR}")
	else()
		dk_error("DKDOWNLOAD_DIR:'${DKDOWNLOAD_DIR}' NOT FOUND")
	endif()
endfunction()
