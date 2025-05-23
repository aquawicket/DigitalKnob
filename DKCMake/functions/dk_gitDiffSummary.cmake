#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_gitDiffSummary()
#
#
function(dk_gitDiffSummary)
	dk_debugFunc(0)
  
	dk_validate(ENV{DKBRANCH_DIR} "dk_DKBRANCH_DIR()")
    dk_chdir($ENV{DKBRANCH_DIR})
    
	dk_depend(git)

    execute_process(COMMAND "${GIT_EXE}" --no-pager diff --compact-summary WORKING_DIRECTORY ${PWD})
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_gitDiffSummary()
endfunction()
