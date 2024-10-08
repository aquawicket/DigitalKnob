#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_gitUpdate(url, branch, NO_CONFIRM)
#
#
dk_gitUpdate() {
	dk_debugFunc 2 3

	[ -n $1 ] && url="$1"    || url="https://github.com/aquawicket/DigitalKnob.git"
	[ -n $2 ] && branch="$2" || branch="Development"
	
	if ! [ "${3-}" = "NO_CONFIRM" ]; then
		dk_call dk_info "Git Update? Any local changes will be lost."
		dk_call dk_confirm || return 0
	fi
	
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	dk_call dk_validate GIT_EXE "dk_call dk_installGit"
	if [ ! -d "${DKBRANCH_DIR}/.git" ]; then
		dk_call dk_printVar DKBRANCH_DIR
		dk_call dk_makeDirectory "${DKBRANCH_DIR}"
		${SUDO_EXE} "${GIT_EXE}" clone ${url} "${DKBRANCH_DIR}"
		
		#[ -n "${DKUSERNAME-}" ] && ${SUDO_EXE} chown -R ${DKUSERNAME} "${DKBRANCH_DIR}"
	fi
	
	"${GIT_EXE}" -C "${DKBRANCH_DIR}" pull --all
	"${GIT_EXE}" -C "${DKBRANCH_DIR}" checkout -- .
	"${GIT_EXE}" -C "${DKBRANCH_DIR}" checkout "${DKBRANCH}"
	if [ "${?}" = "0" ]; then
		dk_call dk_info "${DKBRANCH} branch selected"
	else
		dk_call dk_info "Remote has no branch named ${DKBRANCH}. Creating..."
		"${GIT_EXE}" -C "${DKBRANCH_DIR}" checkout -b "${DKBRANCH}" main
		"${GIT_EXE}" -C "${DKBRANCH_DIR}" push --set-upstream origin "${DKBRANCH}"
	fi
	#dk_call dk_call ${SUDO_EXE} chmod +x "${DKBRANCH_DIR}"/build
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
}
