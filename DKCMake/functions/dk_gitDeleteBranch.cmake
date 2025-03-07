#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_gitDeleteBranch()
#
#   reference: https://stackoverflow.com/a/2003515/688352
#
function(dk_gitDeleteBranch)
	dk_debugFunc(1)
	
	set(branch ${ARGV0})
	
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	dk_validate(GIT_EXE "dk_installGit()")              
	execute_process(COMMAND "${GIT_EXE}" push -d origin ${branch} WORKING_DIRECTORY ${DKBRANCH_DIR})	# Delete remote branch
	execute_process(COMMAND "${GIT_EXE}" branch -d ${branch} WORKING_DIRECTORY ${DKBRANCH_DIR})					# Delete local branch
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_gitDeleteBranch("new_branch")
endfunction()