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
# dk_setEnv(varname value)
#
#	Set a system environment variable
#
#	@varname	- The name of the system environment variable to set
#	@value		- The value to set the system environment vairable to
#
function(dk_setEnv varname)
	if(COMMAND dk_debugFunc)
		dk_debugFunc(2 99)
	endif()
	
	if(ARGC LESS 2)
		dk_fatal("dk_setEnv(${ARGV}): not enough arguments, expected at least 2, got ${ARGC}")
	endif()
	
	string(REPLACE "ENV{" "" varname "${ARGV0}")
	string(REPLACE "CACHE{" "" varname "${varname}")
	string(REPLACE "}" "" varname "${varname}")
	
	cmake_path(CONVERT "${ARGN}" TO_NATIVE_PATH_LIST value NORMALIZE)
	set(ENV{${varname}} "${value}")
	
	#dk_debug("ENV{${varname}} = $ENV{${varname}}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_setEnv(Test "C:/Users/Administrator/DigitalKnob/Development/README.md")
	dk_debug("ENV{Test} = '$ENV{Test}'")
endfunction()