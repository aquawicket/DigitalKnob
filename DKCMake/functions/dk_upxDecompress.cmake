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
# dk_upxDecompress(path)
#
#	Decompress a upx compressed file
#
#	@path		- The full path to the binary file to decompress with upx
#
function(dk_upxDecompress)
	dk_debugFunc(1)
	
	set(path "${ARGV0}")
	dk_assertPath(path)
	dk_depend(upx)
	unset(ENV{upx})
	
	dk_info("upx decompression ${path}, Please wait...")
	
	file(SIZE "${path}" FILESIZE)
	dk_info("File size before upx decompression ${FILESIZE}")
	
	set(comand ${upx_exe} -d ${path})
	dk_exec(${comand})
	
	file(SIZE "${path}" FILESIZE)
	dk_info("File size after upx decompression ${FILESIZE}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_upxDecompress("C:/Windows/notepad.exe")
endfunction()