#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_gitCommit()
#
#
function(dk_gitCommit)
	dk_debugFunc()

	dk_gitDiffSummary()
	
	dk_info("Please enter some details about this commit, Then press ENTER.")
	dk_keyboardInput(commit_msg)
	
	dk_validate(ENV{DKBRANCH_DIR} "dk_DKBRANCH_DIR()")
	dk_chdir("$ENV{DKBRANCH_DIR}")
	
	execute_process(COMMAND "${GIT_EXE}" config credential.helper WORKING_DIRECTORY ${PWD} OUTPUT_VARIABLE STORE)
	if(NOT STORE)
		execute_process(COMMAND "${GIT_EXE}" config --global credential.helper store WORKING_DIRECTORY ${PWD})
		dk_echo()
		dk_info("git credential.helper is now set to store")
		dk_echo()
	endif()
	
	execute_process(COMMAND "${GIT_EXE}" config --global user.email WORKING_DIRECTORY ${PWD} OUTPUT_VARIABLE USER_EMAIL)
	if(NOT USER_EMAIL)
		dk_echo()
		dk_info("please enter an email address")
		dk_keyboardInput(input)
		execute_process(COMMAND "${GIT_EXE}" config --global user.email "${input}" WORKING_DIRECTORY ${PWD})
		dk_echo()
		dk_info("git user.email '${input}' saved")
		dk_echo()
	endif()
	
	execute_process(COMMAND "${GIT_EXE}" config --global user.name WORKING_DIRECTORY ${PWD} OUTPUT_VARIABLE USER_NAME)
	if(NOT USER_NAME)
		dk_echo()
		dk_info("please enter a username")
		dk_keyboardInput(input)
		execute_process(COMMAND "${GIT_EXE}" config --global user.name "${input}" WORKING_DIRECTORY ${PWD})
		dk_echo()
		dk_info("git user.name '${input}' saved")
		dk_echo()
	endif()
	
	if(NOT commit_msg)
		set(commit_msg "git commit")
	endif()
	
	dk_echo()
	dk_info("git commit \"${commit_msg}\"")
	dk_confirm(result)
	if(NOT result)
		return()
	endif()
	
	execute_process(COMMAND "${GIT_EXE}" commit -a -m "${commit_msg}" WORKING_DIRECTORY ${PWD})
	execute_process(COMMAND "${GIT_EXE}" push WORKING_DIRECTORY ${PWD})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_gitCommit()
endfunction()