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
# dk_upxCompress(path)
#
#	upx compress an executable or dynamic library file
#
#	@path		- The full path to the binary file to compress with upx
#
function(dk_upxCompress)
	dk_debugFunc(1)
	
	set(path "${ARGV0}")
	dk_assertPath(path)
	dk_depend(upx)
	unset(ENV{upx})
	
	dk_info("upx compressing ${path}, Please wait...")
	
	file(SIZE "${path}" FILESIZE)
	dk_info("File size before upx compression ${FILESIZE}")
	
	set(comand ${upx_exe} -9 -v --force ${path})
	dk_exec(${comand})
	
	file(SIZE "${path}" FILESIZE)
	dk_info("File size after upx compression ${FILESIZE}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_upxCompress("C:/Windows/notepad.exe")
endfunction()