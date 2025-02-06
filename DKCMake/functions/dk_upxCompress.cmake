#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_upxCompress(path)
#
#	UPX compress an executable or dynamic library file
#
#	@path		- The full path to the binary file to compress with UPX
#
function(dk_upxCompress path)
	dk_debugFunc(1)
	
	dk_assertPath(path)
	dk_info("UPX compressing ${path}...")
	dk_info("Please wait...")
	execute_process(COMMAND ${UPX_EXE} -9 -v ${path} ECHO_OUTPUT_VARIABLE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_upxCompress("C:/Windows/HelpPane.exe")
endfunction()