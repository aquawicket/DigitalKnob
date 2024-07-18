include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_source(filepath)
#
#
function(dk_source filepath)
	dk_debugFunc(${ARGV})
	
	if(NOT EXISTS ${filepath})
		dk_error("${filepath} dows not exist")
	endif()
	
	include(${filepath} OPTIONAL RESULT_VARIABLE sourced_file)
	
	if(NOT sourced_file)
		dk_error("${filepath} failed to load.  ${sourced_file}")
	else()
		dk_info("Loaded ${sourced_file}")
	endif()
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()
