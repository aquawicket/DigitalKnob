#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_gitCheckRemote()
#
#
dk_gitCheckRemote() {
	dk_debugFunc 0
	
	ahead=0
	behind=0
	if [ -d "${DKBRANCH_DIR}/.git" ]; then
		cd "${DKBRANCH_DIR}"
		${GIT_EXE} remote update
		branch=$(${GIT_EXE} rev-parse --abbrev-ref HEAD)
		ahead=$(${GIT_EXE} rev-list --count origin/${branch}..${branch})
		behind=$(${GIT_EXE} rev-list --count ${branch}..origin/${branch})
		dk_call dk_info "${ahead} commits ahead, ${behind} commits behind"
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitCheckRemote
}
