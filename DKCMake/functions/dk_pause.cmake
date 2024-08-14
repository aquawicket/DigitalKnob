include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##############################################################################
# dk_pause()
# 
#	Pause execution and wait for keypress to continue
#
function(dk_pause) 
	dk_debugFunc(${ARGV})

#	message(${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE})
	find_program(CMD_EXE cmd.exe)
	if(CMD_EXE)
		execute_process(COMMAND cmd /c pause)
		#dk_validate(DKBATCH_DIR "dk_getDKPaths()")
		#execute_process(COMMAND cmd /c ${DKBATCH_FUNCTIONS_DIR}/dk_pause.cmd)
		return()
	endif()
	
	find_program(BASH_EXE bash)
	if(BASH_EXE)
		dk_validate(DKBASH_DIR "dk_getDKPaths()")
		#execute_process(COMMAND bash -c 'source ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh; dk_pause')
		execute_process(COMMAND ${DKBASH_FUNCTIONS_DIR}/dk_pause.sh & dk_pause)
		return()
	endif()
		
	dk_error("dk_pause() failed:   both CMD_EXE and BASH_EXE are invalid!")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_pause()
endfunction()
