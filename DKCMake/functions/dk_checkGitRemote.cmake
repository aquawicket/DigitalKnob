include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_checkGitRemote()
#
#
function(dk_checkGitRemote)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 0)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	set(ahead 0)
	set(behind 0)
	if(EXISTS "${DKBRANCH_DIR}/.git")

		dk_fixme()
#		cd "${DKBRANCH_DIR}"
#		${GIT_EXE} remote update

		dk_fixme()
#		branch = $(${GIT_EXE} rev-parse --abbrev-ref HEAD)
#		ahead = $(${GIT_EXE} rev-list --count origin/${branch}..${branch})
#		behind = $(${GIT_EXE} rev-list --count ${branch}..origin/${branch})
		dk_info("${ahead} commits ahead, ${behind} commits behind")
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_checkGitRemote()
endfunction()