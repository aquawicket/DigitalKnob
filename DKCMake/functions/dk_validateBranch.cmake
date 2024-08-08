include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_validateBranch()
#
#
function(dk_validateBranch)
	dk_debugFunc(${ARGV})
	
	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	dk_dirname(${CMAKE_CURRENT_LIST_DIR} FOLDER)
	dk_set(DKBRANCH "Development")
	
	dk_validate(DIGITALKNOB_DIR "dk_getDKPaths()")
	if(EXISTS "${DIGITALKNOB_DIR}/${DKBRANCH}/.git")
#		BRANCH="$(${GIT_EXE} rev-parse --abbrev-ref HEAD)"
#		if [ "${BRANCH}" = "${FOLDER}" ]; then
#			DKBRANCH="${FOLDER}"
#		fi
	endif()
	dk_printVar(DKBRANCH)
	
	dk_set(DKBRANCH_DIR "${DIGITALKNOB_DIR}/${DKBRANCH}")
		dk_set(DKCMAKE_DIR "${DKBRANCH_DIR}/DKCMake")
			dk_set(DKCMAKE_FUNCTIONS_DIR "${DKCMAKE_DIR}/functions")
		dk_set(DK3RDPARTY_DIR "${DKBRANCH_DIR}/3rdParty")	
		dk_set(DKIMPORTS_DIR "${DK3RDPARTY_DIR}/_DKIMPORTS")	
		dk_set(DKAPPS_DIR "${DKBRANCH_DIR}/DKApps")
		dk_set(DKPLUGINS_DIR "${DKBRANCH_DIR}/DKPlugins")
		dk_set(DKBASH_DIR "${DKBRANCH_DIR}/DKBash")
			dk_set(DKBASH_FUNCTIONS_DIR "${DKBASH_DIR}/functions")
		dk_set(DKBATCH_DIR "${DKBRANCH_DIR}/DKBatch")
			dk_set(DKBATCH_FUNCTIONS_DIR "${DKBATCH_DIR}/functions")
		dk_set(DKPOWERSHELL_DIR "${DKBRANCH_DIR}/DKPowershell")
			dk_set(DKPOWERSHELL_FUNCTIONS_DIR "${DKPOWERSHELL_DIR}/functions")
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_validateBranch()
endfunction()
