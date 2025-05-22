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

##############################################################################
# dk_fileSize(path)
# 
#
function(dk_fileSize)
	dk_debugFunc(1)
	
	set(path "${ARGV0}")
	dk_assertPath(${path})
	file(SIZE "${path}" dk_fileSize)
	set(dk_fileSize ${dk_fileSize} PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_fileSize("C:/Windows/notepad.exe")
	dk_echo("filesize of notepad is ${dk_fileSize}")
endfunction()
