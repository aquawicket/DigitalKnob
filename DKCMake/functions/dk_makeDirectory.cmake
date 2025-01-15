#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_makeDirectory(path)
#
#	Create a directory 
#
#	@path	- The full path to the direcotory to be created
#
function(dk_makeDirectory)
	dk_debugFunc(1)
	
	set(path "${ARGV0}")
	message("make_directory("${path}")")
	dk_pause()
	make_directory("${path}")  # requires full path
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_makeDirectory("C:/test")
endfunction()