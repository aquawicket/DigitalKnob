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
# dk_upxDecompress(path)
#
#	Decompress a UPX compressed file
#
#	@path		- The full path to the binary file to decompress with UPX
#
function(dk_upxDecompress)
	dk_debugFunc(1)
	
	set(path "${ARGV0}")
	dk_assertPath(path)
	dk_depend(upx)
	unset(ENV{UPX})
	
	dk_info("UPX decompression ${path}, Please wait...")
	
	file(SIZE "${path}" FILESIZE)
	dk_info("File size before UPX decompression ${FILESIZE}")
	
	set(comand ${UPX_EXE} -d ${path})
	message("comand = ${comand}")
	execute_process(COMMAND ${comand})
	
	file(SIZE "${path}" FILESIZE)
	dk_info("File size after UPX decompression ${FILESIZE}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_upxDecompress("C:/Windows/notepad.exe")
endfunction()