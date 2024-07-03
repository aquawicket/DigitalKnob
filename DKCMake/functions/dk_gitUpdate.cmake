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

	dk_getOption(NO_CONFIRM ${ARGV})
	if(NOT NO_CONFIRM)
		dk_info("Git Update? Any local changes will be lost.")
		dk_confirm(result) 
		if(NOT result)
			return()
		endif()
	endif()
	
	dk_validate(GIT_EXE "dk_installGit()")
	if(NOT EXISTS "${DKBRANCH_DIR}/.git")
		dk_printVar(DKBRANCH_DIR)
		dk_command("${GIT_EXE}" clone https://github.com/aquawicket/DigitalKnob.git "${DKBRANCH_DIR}")
	endif()
	dk_command(cd "${DKBRANCH_DIR}") #|| dk_error "cd $${DKBRANCH_DIR} failed!"
	dk_command("${GIT_EXE}" pull --all)
	dk_command("${GIT_EXE}" checkout -- .)
	dk_command("${GIT_EXE}" checkout "${DKBRANCH}" RESULT_VARIABLE checkout_result)
	if(${checkout_result} EQUAL 0)
		dk_info "${DKBRANCH} branch selected"
	else()
		dk_info("Remote has no ${DKBRANCH} branch. Creating...")
		dk_command("${GIT_EXE}" checkout -b "${DKBRANCH}" main)
		dk_command("${GIT_EXE}" push --set-upstream origin "${DKBRANCH}")
	endif()
	#dk_command(chmod +x "${DKBRANCH_DIR}"/build)
endfunction()



function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_checkGitRemote()
endfunction()