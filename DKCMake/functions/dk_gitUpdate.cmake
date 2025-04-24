#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_gitUpdate()
#
#
function(dk_gitUpdate)
<<<<<<< HEAD
	dk_debugFunc()

=======
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
	
	dk_validate(ENV{DKBRANCH_DIR} "dk_DKBRANCH_DIR()")
	dk_validate(GIT_EXE "dk_installGit()")
	
	if(NOT EXISTS "$ENV{DKBRANCH_DIR}/.git")
		execute_process(COMMAND "${GIT_EXE}" clone ${url} "$ENV{DKBRANCH_DIR}")
	endif()
	
	execute_process(COMMAND "${GIT_EXE}" -C $ENV{DKBRANCH_DIR} pull --all)
    execute_process(COMMAND "${GIT_EXE}" -C $ENV{DKBRANCH_DIR} checkout -- .)
	
	execute_process(COMMAND "${GIT_EXE}" -C $ENV{DKBRANCH_DIR} checkout ${branch} RESULT_VARIABLE ERRORLEVEL)	
	if(NOT ${ERRORLEVEL} EQUAL 0)
		dk_echo("Remote has no ${branch} branch. Creating...")
		execute_process(COMMAND "${GIT_EXE}" -C $ENV{DKBRANCH_DIR} checkout -b ${branch} main)
		execute_process(COMMAND "${GIT_EXE}" -C $ENV{DKBRANCH_DIR} push --set-upstream origin ${branch})
	endif()
>>>>>>> Development
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_gitUpdate()
endfunction()