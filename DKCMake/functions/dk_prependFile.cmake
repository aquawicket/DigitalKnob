#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_prependFile(path string)
#
#	TODO
#
#	@path	- TODO
#	@string	- TODO
# 
function(dk_prependFile path string)
	dk_debugFunc()
	
	file(READ "${path}" file_data)
	file(write "${pah}" "${string}\n${filedata}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()