#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_gitCommit()
#
#
dk_gitCommit() {	
	dk_debugFunc 0

	dk_call dk_gitDiffSummary
	
	dk_call dk_info "Please enter some details about this commit, Then press ENTER."
	dk_call dk_keyboardInput commit_msg
	
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_validateBranch"
	cd "${DKBRANCH_DIR}" #|| dk_call dk_error "cd \${DKBRANCH_DIR} failed!"
	
	if ! STORE=$(${GIT_EXE} config credential.helper); then
		dk_call dk_errorStatus
	fi
	if [ -z "${STORE}" ]; then
		dk_call "${GIT_EXE}" config --global credential.helper store
		dk_call dk_echo
		dk_call dk_info "git credential.helper is now set to store"
		dk_call dk_echo
	fi
	
	if ! USER_EMAIL=$(${GIT_EXE} config --global user.email); then
		dk_call dk_errorStatus
	fi
	if [ -z "${USER_EMAIL}" ]; then
		dk_call dk_echo
		dk_call dk_info "please enter an email address"
		dk_call dk_keyboardInput input
		dk_call "${GIT_EXE}" config --global user.email "${input}"
		dk_call dk_echo
		dk_call dk_info "git user.email '${input}' saved"
		dk_call dk_echo
	fi
	if ! USER_NAME=$(${GIT_EXE} config --global user.name); then
		dk_call dk_errorStatus
	fi
	if [ -z "${USER_NAME}" ]; then
		dk_call dk_echo
		dk_call dk_info "please enter a username"
		dk_call dk_keyboardInput input
		dk_call "${GIT_EXE}" config --global user.name "${input}"
		dk_call dk_echo
		dk_call dk_info "git user.name '${input}' saved"
		dk_call dk_echo
	fi
	
	if [ -z "${commit_msg}" ]; then
		commit_msg="git commit"
	fi
	
	dk_call dk_echo
	dk_call dk_info "git commit \"${commit_msg}\""
	dk_call dk_confirm || return 0
	
	dk_call "${GIT_EXE}" commit -a -m "${commit_msg}" || $(true)
    dk_call "${GIT_EXE}" push
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitCommit
}
