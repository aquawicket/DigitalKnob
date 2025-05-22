#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_getUnixPath(path unix_path)
#
#	@path		 	- windows in path
#   @unix_path		- The returned unix style path
#
function(dk_getUnixPath path unix_path)
	dk_debugFunc()

	if(WIN32)
		dk_validate(MSYS2 "dk_depend(msys2)")
		execute_process(COMMAND cygpath.exe "${path}" OUTPUT_VARIABLE ${unix_path} OUTPUT_STRIP_TRAILING_WHITESPACE)
		string (STRIP ${unix_path} unix_path)
	endif(WIN32)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()