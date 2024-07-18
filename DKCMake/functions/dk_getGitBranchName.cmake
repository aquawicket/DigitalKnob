include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getGitBranchName(url rtn_var)
#
#	Return the name of the head branch from a git repository
#
#	@url	- The git url
#	@rtn_var	- Returns the name of the head branch
#
#	https://stackoverflow.com/a/31919435
#
function(dk_getGitBranchName url rtn_var)
	dk_debugFunc(${ARGV})
	
	dk_load(${DKIMPORTS_DIR}/git/DKMAKE.cmake)
	dk_assertPath(GIT_EXE)
			
	execute_process(COMMAND ${GIT_EXE} ls-remote ${url} heads/* RESULT_VARIABLE result OUTPUT_VARIABLE gitBranchName)
	set(${rtn_var} ${gitBranchName} PARENT_SCOPE)
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()