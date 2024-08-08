#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_gitUpdate(<NO_CONFIRM:optional>)
#
#
dk_gitUpdate() {
	dk_debugFunc
	[ ${#} -gt 1 ] && dk_error "Too many parameters"

	if ! [ "${1-}" = "NO_CONFIRM" ]; then
		dk_info "Git Update? Any local changes will be lost."
		dk_confirm || return 0
	fi
	
	dk_validate GIT_EXE "dk_installGit"
	if [ ! -d "${DKBRANCH_DIR}/.git" ]; then
		dk_printVar DKBRANCH_DIR
		dk_call ${dksudo} "${GIT_EXE}" clone https://github.com/aquawicket/DigitalKnob.git "${DKBRANCH_DIR}"
		${dksudo} chown -R ${DKUSERNAME} "${DKBRANCH_DIR}"
	fi
	dk_call cd "${DKBRANCH_DIR}" #|| dk_error "cd $${DKBRANCH_DIR} failed!"
	"${GIT_EXE}" pull --all
	dk_call "${GIT_EXE}" checkout -- .
	"${GIT_EXE}" checkout "${DKBRANCH}"
	if [ "${?}" = "0" ]; then
		dk_info "${DKBRANCH} branch selected"
	else
		dk_info "Remote has no ${DKBRANCH} branch. Creating..."
		dk_call "${GIT_EXE}" checkout -b "${DKBRANCH}" main
		dk_call "${GIT_EXE}" push --set-upstream origin "${DKBRANCH}"
	fi
	#dk_call chmod +x "${DKBRANCH_DIR}"/build
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc 0
	
	dk_gitUpdate
}