#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_gitCreateBranch()
#
#
function(dk_gitCreateBranch)
	dk_debugFunc(1)
	
	set(branch ${ARGV0})
	
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	dk_validate(GIT_EXE "dk_installGit()")
	execute_process(COMMAND "${GIT_EXE}" -C ${DKBRANCH_DIR} checkout -b ${branch} main)
	execute_process(COMMAND "${GIT_EXE}" -C ${DKBRANCH_DIR} push --set-upstream origin ${branch})
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_gitCreateBranch("new_branch")
endfunction()