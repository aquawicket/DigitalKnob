#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_gitDiffSummary()
#
#
function(dk_gitDiffSummary)
	dk_debugFunc()
  
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
    dk_cd(${DKBRANCH_DIR})
    
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_validate(GIT_EXE "dk_load('${DKIMPORTS_DIR}/git/DKMAKE.cmake')")

    execute_process(COMMAND "${GIT_EXE}" --no-pager diff --compact-summary WORKING_DIRECTORY ${PWD})
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_gitDiffSummary()
endfunction()
