include_guard()

##############################################################################
# dk_pause()
# 
#	Pause execution and wait for keypress to continue
#
function(dk_pause) 
	#dk_debugFunc(${ARGV})
	
	dk_debug("dk_pause(${ARGV})")
	
	#if(${ARGC} GREATER 0) dk_error "Incorrect number of parameters" endif()
	
	find_program(BASH_EXE bash)
	if(BASH_EXE)
		if(NOT DKBASH_DIR)
			dk_getDKPaths()
		endif()
		#execute_process(COMMAND bash -c 'source ${DKBASH_DIR}/functions/dk_pause.sh; dk_pause')
		execute_process(COMMAND ${DKBASH_DIR}/functions/dk_pause.sh & dk_pause)
		return()
	endif()
	
	find_program(CMD_EXE cmd.exe)
	if(CMD_EXE)
		if(NOT DKBATCH_DIR)
			dk_getDKPaths()
		endif()
		execute_process(COMMAND cmd /c ${DKBATCH_DIR}/functions/dk_pause.cmd & dk_pause)
		return()
	endif()
		
	dk_error("dk_pause() failed:   both CMD_EXE and BASH_EXE are invalid!")
endfunction()