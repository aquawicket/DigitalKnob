#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_gitCommit()
#
#
dk_gitCommit() {	
	dk_debugFunc 0

	
	dk_gitDiffSummary
	
	dk_info "Please enter some details about this commit, Then press ENTER."
	read message
	
	dk_validate DKBRANCH_DIR "dk_validateBranch"
	cd "${DKBRANCH_DIR}" #|| dk_error "cd \${DKBRANCH_DIR} failed!"
	
	if ! STORE=$(${GIT_EXE} config credential.helper); then
		dk_errorStatus
	fi
	if [ -z "${STORE}" ]; then
		${GIT_EXE} config --global credential.helper store
		dk_echo
		dk_info "git credential.helper is now set to store"
		dk_echo
	fi
	
	if ! USER_EMAIL=$(${GIT_EXE} config --global user.email); then
		dk_errorStatus
	fi
	if [ -z "${USER_EMAIL}" ]; then
		dk_echo
		dk_info "please enter an email address"
		read input
		${GIT_EXE} config --global user.email "${input}"
		dk_echo
		dk_info "git user.email '${input}' saved"
		dk_echo
	fi
	if ! USER_NAME=$(${GIT_EXE} config --global user.name); then
		dk_errorStatus
	fi
	if [ -z "${USER_NAME}" ]; then
		dk_echo
		dk_info "please enter a username"
		read input
		${GIT_EXE} config --global user.name "${input}"
		dk_echo
		dk_info "git user.name '${input}' saved"
		dk_echo
	fi
	
	if [ -z "${message}" ]; then
		message="git commit"
	fi
	
	dk_echo
	dk_info "git commit \"${message}\""
	dk_confirm || return 0
	
	"${GIT_EXE}" commit -a -m "${message}"
    dk_call "${GIT_EXE}" push
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc
	
	dk_gitCommit
}