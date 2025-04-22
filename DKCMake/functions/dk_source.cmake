#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_source(filepath)
#
#
function(dk_source func)
	dk_debugFunc(1)
	
	# load if it's an existing full file path
	if(EXISTS ${func})
		include(${func})
		return()
	endif()
	
	# If it's a dk_function, download if it doesn't exist then load it
	if(NOT EXISTS $ENV{DKCMAKE_FUNCTIONS_DIR}/${func}.cmake)
		dk_info("downloading ${func} . . .")
		dk_download($ENV{DKHTTP_DKCMAKE_FUNCTIONS_DIR}/${func}.cmake $ENV{DKCMAKE_FUNCTIONS_DIR}/${func}.cmake)
	endif()
	if(NOT EXISTS $ENV{DKCMAKE_FUNCTIONS_DIR}/${func}.cmake)
		dk_fatal("ERROR: failed to download ${func}") 
	endif()
	include($ENV{DKCMAKE_FUNCTIONS_DIR}/${func}.cmake)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_source("dk_info") 
	dk_info("test message using dk_source to download it first")
endfunction()
