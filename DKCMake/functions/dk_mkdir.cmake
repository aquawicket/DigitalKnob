#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_mkdir(path)
#
#	Create a directory 
#
#	@path	- The full path to the direcotory to be created
#
function(dk_mkdir)
	dk_debugFunc(1)
	
	dk_getArg(0 path)
	
	if(EXISTS "${path}")	# the directory already exists
		dk_return()
	endif()	
	make_directory("${path}")  # requires full path
	
# DEBUG
#	dk_printVar(path)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_mkdir("C:/test")
endfunction()