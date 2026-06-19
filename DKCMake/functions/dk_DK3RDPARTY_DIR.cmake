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
# dk_DK3RDPARTY_DIR()
#
#
function(dk_DK3RDPARTY_DIR)
	dk_debugFunc(0 1)
	
	###### SET ######
	if(ARGV)
		dk_set(DK3RDPARTY_DIR "${ARGV}")
	
	###### GET ######
	elseif(DEFINED ENV{DK3RDPARTY_DIR})	
		file(TO_CMAKE_PATH "$ENV{DK3RDPARTY_DIR}" DK3RDPARTY_DIR)
	else()
		dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
		set(DK3RDPARTY_DIR "${DKBRANCH_DIR}/3rdParty")
	endif()
	
	###### FINALIZE ######
	#dk_assertPath(DK3RDPARTY_DIR)
	dk_set(DK3RDPARTY_DIR "${DK3RDPARTY_DIR}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("Test Getting DK3RDPARTY_DIR . . .")
	dk_DK3RDPARTY_DIR()
	if(EXISTS "${DK3RDPARTY_DIR}")
		dk_success("DK3RDPARTY_DIR = ${DK3RDPARTY_DIR}")
	else()
		dk_error("DK3RDPARTY_DIR:'${DK3RDPARTY_DIR}' NOT FOUND")
	endif()
	
	dk_echo()
	dk_echo("Test Setting DK3RDPARTY_DIR . . .")
	dk_DK3RDPARTY_DIR("C:/DigitalKnob/Development/3rdParty")
	if(EXISTS "${DK3RDPARTY_DIR}")
		dk_success("DK3RDPARTY_DIR = ${DK3RDPARTY_DIR}")
	else()
		dk_error("DK3RDPARTY_DIR:'${DK3RDPARTY_DIR}' NOT FOUND")
	endif()
endfunction()
