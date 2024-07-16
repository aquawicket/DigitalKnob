#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_checkGitRemote()
#
#
dk_checkGitRemote() {
	dk_debugFunc
	[ ${#} -ne 0 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	ahead=0
	behind=0
	if [ -d "${DKBRANCH_DIR}/.git" ]; then
		cd "${DKBRANCH_DIR}"
		${GIT_EXE} remote update
		branch=$(${GIT_EXE} rev-parse --abbrev-ref HEAD)
		ahead=$(${GIT_EXE} rev-list --count origin/${branch}..${branch})
		behind=$(${GIT_EXE} rev-list --count ${branch}..origin/${branch})
		dk_info "${ahead} commits ahead, ${behind} commits behind"
	fi
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_checkGitRemote
}