#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_upxCompress(path)
#
#	UPX compress an executable or dynamic library file
#
#	@path		- The full path to the binary file to compress with UPX
#
function(dk_upxCompress path)
	dk_debugFunc()
	
	dk_info("UPX compressing ${path}...")
	dk_info("Please wait...")
	dk_executeProcess("${UPX_EXE} -9 -v ${path}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()