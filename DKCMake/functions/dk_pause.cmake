include_guard()

##############################################################################
# dk_pause()
# 
#	Pause execution and wait for keypress to continue
#
macro(dk_pause) 
	DKDEBUGFUNC(${ARGV})
	#if(${ARGC} GREATER 0) dk_error "Incorrect number of parameters" endif()
	
	if(WIN32)
		if(NOT DKBATCH_DIR)
			dk_getDKPaths()
		endif()
		execute_process(COMMAND cmd /c ${DKBATCH_DIR}/functions/dk_pause.cmd)
	elseif(CMAKE_HOST_UNIX)
		if(NOT DKBASH_DIR)
			dk_getDKPaths()
		endif()
		execute_process(COMMAND ${DKBASH}/functions/dk_pause.sh)
	else()
		dk_error("dk_pause(): Not implemented on this platform")
	endif()	
endmacro()
