#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_source(filepath)
#
#
function(dk_source func)
	dk_debugFunc()
	
	# load if it's an existing full path file
	if(EXISTS ${func})
		include(${func})
	endif()
	
	# If it's a dk_function, download if it doesn't exist then load it
	if(NOT EXISTS ${DKCMAKE_FUNCTIONS_DIR}/${func}.cmake)
		dk_info("downloading ${func} . . .")
		dk_download(${DKHTTP_DKCMAKE_FUNCTIONS_DIR}/${func}.cmake ${DKCMAKE_FUNCTIONS_DIR}/${func}.cmake)
	endif()
	if(NOT EXISTS ${DKCMAKE_FUNCTIONS_DIR}/${func}.cmake)
		dk_fatal("ERROR: failed to download ${func}") 
	endif()
	include(${DKCMAKE_FUNCTIONS_DIR}/${func}.cmake)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_source("dk_info") 
	dk_info("test message using dk_source to download it first")
endfunction()
