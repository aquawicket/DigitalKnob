#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_gitCheckRemote()
#
#
dk_gitCheckRemote() {
	dk_debugFunc 0
	
	ahead=0
	behind=0
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	if [ -d "${DKBRANCH_DIR}/.git" ]; then
		dk_call dk_validate GIT_EXE "dk_call dk_installGit"
		${GIT_EXE} -C ${DKBRANCH_DIR} remote update
		branch=$(${GIT_EXE} -C ${DKBRANCH_DIR} rev-parse --abbrev-ref HEAD)
		ahead=$(${GIT_EXE} -C ${DKBRANCH_DIR} rev-list --count origin/${branch}..${branch})
		behind=$(${GIT_EXE} -C ${DKBRANCH_DIR} rev-list --count ${branch}..origin/${branch})
		dk_call dk_info "${ahead} commits ahead, ${behind} commits behind"
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitCheckRemote
}
