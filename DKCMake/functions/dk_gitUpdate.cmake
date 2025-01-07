#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_gitUpdate()
#
#
function(dk_gitUpdate)
	dk_debugFunc(2 3)

	if(ARGV0)
		set(url ${ARGV0}) 
	else()
		set(url "https://github.com/aquawicket/DigitalKnob.git")
	endif()
	
	if(ARGV1)
		set(branch ${ARGV1})
	else()
		set(branch "Development")
	endif()
	
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	dk_validate(GIT_EXE "dk_installGit()")
	
	if(NOT EXISTS "${DKBRANCH_DIR}/.git")
		execute_process(COMMAND "${GIT_EXE}" clone ${url} "${DKBRANCH_DIR}")
	endif()
	
	execute_process(COMMAND "${GIT_EXE}" -C ${DKBRANCH_DIR} pull --all)
    execute_process(COMMAND "${GIT_EXE}" -C ${DKBRANCH_DIR} checkout -- .)
	
	execute_process(COMMAND "${GIT_EXE}" -C ${DKBRANCH_DIR} checkout ${branch} RESULT_VARIABLE ERRORLEVEL)	
	if(NOT ${ERRORLEVEL} EQUAL 0)
		dk_echo("Remote has no ${branch} branch. Creating...")
		execute_process(COMMAND "${GIT_EXE}" -C ${DKBRANCH_DIR} checkout -b ${branch} main)
		execute_process(COMMAND "${GIT_EXE}" -C ${DKBRANCH_DIR} push --set-upstream origin ${branch})
	endif()
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_gitUpdate()
endfunction()