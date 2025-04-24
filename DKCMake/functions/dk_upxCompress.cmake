#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_upxCompress(path)
#
#	UPX compress an executable or dynamic library file
#
#	@path		- The full path to the binary file to compress with UPX
#
<<<<<<< HEAD
function(dk_upxCompress path)
	dk_debugFunc()
	
	dk_info("UPX compressing ${path}...")
	dk_info("Please wait...")
	dk_executeProcess("${UPX_EXE} -9 -v ${path}")
=======
function(dk_upxCompress)
	dk_debugFunc(1)
	
	set(path "${ARGV0}")
	dk_assertPath(path)
	dk_depend(upx)
	unset(ENV{UPX})
	
	dk_info("UPX compressing ${path}, Please wait...")
	
	file(SIZE "${path}" FILESIZE)
	dk_info("File size before UPX compression ${FILESIZE}")
	
	set(comand ${UPX_EXE} -9 -v --force ${path})
	message("comand = ${comand}")
	execute_process(COMMAND ${comand})
	
	file(SIZE "${path}" FILESIZE)
	dk_info("File size after UPX compression ${FILESIZE}")
>>>>>>> Development
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_upxCompress("C:/Windows/notepad.exe")
>>>>>>> Development
endfunction()