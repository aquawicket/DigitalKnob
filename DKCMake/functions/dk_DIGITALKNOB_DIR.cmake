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
# dk_DIGITALKNOB_DIR()
#
#
function(dk_DIGITALKNOB_DIR)
	dk_debugFunc()

	###### SET ######
	if(ARGV)
		dk_call( dk_set(DIGITALKNOB_DIR "${ARGV0}") )

	###### GET ######
	elseif(DEFINED ENV{DIGITALKNOB_DIR})
		file(TO_CMAKE_PATH "$ENV{DIGITALKNOB_DIR}" DIGITALKNOB_DIR)
	else()
		dk_validate(DKHOME_DIR dk_DKHOME_DIR())
	
		if(NOT DEFINED DIGITALKNOB) 
		#	dk_set(DIGITALKNOB "D i g i t a l K n o b") 
			dk_call( dk_set(DIGITALKNOB "DigitalKnob") )
		endif()

		set(DIGITALKNOB_DIR "${DKHOME_DIR}/${DIGITALKNOB}")
	endif()
	
	###### FINALIZE ######
	if(NOT EXISTS "${DIGITALKNOB_DIR}")
		dk_call( dk_mkdir("${DIGITALKNOB_DIR}") )
	endif()
	
	#dk_assertPath(DIGITALKNOB_DIR)
	dk_call( dk_set(DIGITALKNOB_DIR "${DIGITALKNOB_DIR}") )
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
   
	dk_echo()
	dk_echo("Test Getting DIGITALKNOB_DIR . . .")
	dk_DIGITALKNOB_DIR()
	if(EXISTS "${DIGITALKNOB_DIR}")
		dk_success("DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}")
	else()
		dk_error("DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}")
	endif()
	
	dk_echo()
	dk_echo("Test Setting DIGITALKNOB_DIR . . .")
	dk_DIGITALKNOB_DIR("C:/DigitalKnob")
	if(EXISTS "${DIGITALKNOB_DIR}")
		dk_success("DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}")
	else()
		dk_error("DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}")
	endif()
endfunction()
