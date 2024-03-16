include_guard()

###############################################################################
# dk_getGitBranchName(url RESULT)
#
#	Return the name of the head branch from a git repository
#
#	@url	- The git url
#	@RESULT	- Returns the name of the head branch
#
#	https://stackoverflow.com/a/31919435
#
function(dk_getGitBranchName url RESULT)
	DKDEBUGFUNC(${ARGV})
	
	#include(${DKIMPORTS_DIR}/git/DKMAKE.cmake)
	dk_load(git)
	DKASSERT(GIT_EXE)
			
	execute_process(COMMAND ${GIT_EXE} ls-remote ${url} heads/* RESULT_VARIABLE result OUTPUT_VARIABLE output)
	set(${RESULT} ${output} PARENT_SCOPE)
endfunction()