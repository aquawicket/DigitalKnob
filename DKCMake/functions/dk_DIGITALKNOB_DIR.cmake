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

####################################################################
# dk_DIGITALKNOB_DIR()
#
#
function(dk_DIGITALKNOB_DIR)
	dk_debugFunc()

	###### SET ######
	if(ARGV)
		dk_set(ENV{DIGITALKNOB_DIR} "${ARGV}")

	###### GET ######
	elseif(DEFINED ENV{DIGITALKNOB_DIR})	
		dk_set(ENV{DIGITALKNOB_DIR} "$ENV{DIGITALKNOB_DIR}")
	
	else()
		dk_validate(DKHOME_DIR "dk_DKHOME_DIR()")
	
		if(NOT DEFINED DIGITALKNOB) 
		#	dk_set(DIGITALKNOB "D i g i t a l K n o b") 
			dk_set(DIGITALKNOB "DigitalKnob")
		endif()

		dk_set(ENV{DIGITALKNOB_DIR} "${DKHOME_DIR}/${DIGITALKNOB}")
	endif()
	
	###### FINALIZE ######
	if(NOT EXISTS "$ENV{DIGITALKNOB_DIR}")
		dk_mkdir("$ENV{DIGITALKNOB_DIR}")
	endif()
	
	#dk_assertPath(DIGITALKNOB_DIR)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
   
	dk_echo()
	dk_echo("Test Getting DIGITALKNOB_DIR . . .")
	dk_DIGITALKNOB_DIR()
	if(EXISTS "$ENV{DIGITALKNOB_DIR}")
		dk_success("DIGITALKNOB_DIR = $ENV{DIGITALKNOB_DIR}")
	else()
		dk_error("DIGITALKNOB_DIR = $ENV{DIGITALKNOB_DIR}")
	endif()
	
	dk_echo()
	dk_echo("Test Setting DIGITALKNOB_DIR . . .")
	dk_DIGITALKNOB_DIR("C:/DigitalKnob")
	if(EXISTS "$ENV{DIGITALKNOB_DIR}")
		dk_success("DIGITALKNOB_DIR = $ENV{DIGITALKNOB_DIR}")
	else()
		dk_error("DIGITALKNOB_DIR = $ENV{DIGITALKNOB_DIR}")
	endif()
endfunction()
