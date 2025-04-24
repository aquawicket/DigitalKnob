#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

################################################################################
# dk_gitDiffSummary()
#
#
function(dk_gitDiffSummary)
<<<<<<< HEAD
	dk_debugFunc()
  
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
    dk_cd(${DKBRANCH_DIR})
    
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	dk_validate(GIT_EXE "dk_load('${DKIMPORTS_DIR}/git/DKMAKE.cmake')")
=======
	dk_debugFunc(0)
  
	dk_validate(ENV{DKBRANCH_DIR} "dk_DKBRANCH_DIR()")
    dk_chdir($ENV{DKBRANCH_DIR})
    
	dk_depend(git)
>>>>>>> Development

    execute_process(COMMAND "${GIT_EXE}" --no-pager diff --compact-summary WORKING_DIRECTORY ${PWD})
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_gitDiffSummary()
endfunction()
