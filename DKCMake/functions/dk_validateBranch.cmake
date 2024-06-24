include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_validateBranch()
#
#
function(dk_validateBranch)
	dk_debugFunc(${ARGV})
	
	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	dk_getDirname(${CMAKE_CURRENT_LIST_DIR} FOLDER)
	dk_set(DKBRANCH "Development")
	
	dk_validate(DIGITALKNOB_DIR "dk_getDKPaths")
	if(EXISTS "${DIGITALKNOB_DIR}/${DKBRANCH}/.git")
#		BRANCH="$(${GIT_EXE} rev-parse --abbrev-ref HEAD)"
#		if [ "${BRANCH}" = "${FOLDER}" ]; then
#			DKBRANCH="${FOLDER}"
#		fi
	endif()
	dk_printVar(DKBRANCH)
	
	dk_set(DKBRANCH_DIR "${DIGITALKNOB_DIR}/${DKBRANCH}")
	dk_printVar(DKBRANCH_DIR)
	
	dk_set(DKCMAKE_DIR "${DKBRANCH_DIR}/DKCMake")
	dk_printVar(DKCMAKE_DIR)
	
	dk_set(DK3RDPARTY_DIR "${DKBRANCH_DIR}/3rdParty")
	dk_printVar(DK3RDPARTY_DIR)
	
	dk_set(DKIMPORTS_DIR "${DK3RDPARTY_DIR}/_DKIMPORTS")
	dk_printVar(DKIMPORTS_DIR)
	
	dk_set(DKAPPS_DIR "${DIGITALKNOB_DIR}/${DKBRANCH}/DKApps")
	dk_printVar(DKAPPS_DIR)
	
	dk_set(DKPLUGINS_DIR "${DIGITALKNOB_DIR}/${DKBRANCH}/DKPlugins")
	dk_printVar(DKPLUGINS_DIR)
	
	dk_set(DKBASH_DIR "${DIGITALKNOB_DIR}/${DKBRANCH}/DKBash")
	dk_printVar(DKBASH_DIR)
	
	dk_set(DKBATCH_DIR "${DIGITALKNOB_DIR}/${DKBRANCH}/DKBatch")
	dk_printVar(DKBATCH_DIR)
	
	dk_set(DKPOWERSHELL_DIR "${DIGITALKNOB_DIR}/${DKBRANCH}/DKPowershell")
	dk_printVar(DKPOWERSHELL_DIR)
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()
