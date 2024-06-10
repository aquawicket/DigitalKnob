include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

##############################################################################
# dk_pause()
# 
#	Pause execution and wait for keypress to continue
#
function(dk_pause) 
	dk_debugFunc(${ARGV})

	find_program(CMD_EXE cmd.exe)
	if(CMD_EXE)
		#dk_validate(DKBATCH_DIR "dk_getDKPaths()")
		#execute_process(COMMAND cmd /c ${DKBATCH_DIR}/functions/dk_pause.cmd & dk_pause WORKING_DIRECTORY ${DKBATCH_DIR}/functions)
		execute_process(COMMAND cmd /c pause)
		return()
	endif()
	
	find_program(BASH_EXE bash)
	if(BASH_EXE)
		dk_validate(DKBASH_DIR "dk_getDKPaths()")
		#execute_process(COMMAND bash -c 'source ${DKBASH_DIR}/functions/dk_pause.sh; dk_pause')
		execute_process(COMMAND ${DKBASH_DIR}/functions/dk_pause.sh & dk_pause)
		return()
	endif()
		
	dk_error("dk_pause() failed:   both CMD_EXE and BASH_EXE are invalid!")
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_pause()

endfunction(DKTEST)