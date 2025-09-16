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
# dk_ndkDebug(path)
#
#	TODO
#
#	@path		- TODO
#
function(dk_ndkDebug path)
	dk_debugFunc()
	
	if(NOT EXISTS ${path})
		dk_fatal("dk_ndkDebug(${path}) path does not exist")
	endif()
	
	if(Debug)
		if(Windows_Host)
			dk_exec(${android-ndk}/ndk-build.cmd WORKING_DIRECTORY ${path}/${Target_Tuple}/Debug)
		endif()
		if(UNIX_HOST)
			dk_exec(${android-ndk}/ndk-build WORKING_DIRECTORY ${path}/${Target_Tuple}/Debug)
		endif()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()