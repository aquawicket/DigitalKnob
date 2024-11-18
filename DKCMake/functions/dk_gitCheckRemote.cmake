#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_gitCheckRemote()
#
#
function(dk_gitCheckRemote)
	dk_debugFunc(0)
	
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	if(EXISTS "${DKBRANCH_DIR}/.git")
		#set(ahead -1)
		#set(behind -1)
		
		#dk_printVar(DKBRANCH_DIR)
		dk_cd("${DKBRANCH_DIR}")
		#dk_printVar(PWD)
		
		dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
		dk_validate(GIT_EXE "dk_load(${DKIMPORTS_DIR}/git/DKMAKE.cmake)")

#		${GIT_EXE} remote update
		execute_process(COMMAND ${GIT_EXE} remote update WORKING_DIRECTORY ${PWD} OUTPUT_STRIP_TRAILING_WHITESPACE COMMAND_ECHO STDOUT)
		
#		branch = $(${GIT_EXE} rev-parse --abbrev-ref HEAD)
		execute_process(COMMAND ${GIT_EXE} rev-parse --abbrev-ref HEAD WORKING_DIRECTORY ${PWD} OUTPUT_VARIABLE branch OUTPUT_STRIP_TRAILING_WHITESPACE COMMAND_ECHO STDOUT)
		
#		ahead = $(${GIT_EXE} rev-list --count origin/${branch}..${branch})
		execute_process(COMMAND ${GIT_EXE} rev-list --count origin/${branch}..${branch} WORKING_DIRECTORY ${PWD} OUTPUT_VARIABLE ahead OUTPUT_STRIP_TRAILING_WHITESPACE COMMAND_ECHO STDOUT)

#		behind = $(${GIT_EXE} rev-list --count ${branch}..origin/${branch})
		execute_process(COMMAND ${GIT_EXE} rev-list --count ${branch}..origin/${branch} WORKING_DIRECTORY ${PWD} OUTPUT_VARIABLE behind OUTPUT_STRIP_TRAILING_WHITESPACE COMMAND_ECHO STDOUT)
		
		dk_info("${ahead} commits ahead, ${behind} commits behind")
		dk_set(behind ${behind})
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc()
	
	dk_gitCheckRemote()
endfunction()