#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_gitCommit()
#
#
dk_gitCommit() {	
	dk_debugFunc 0


	dk_call dk_gitDiffSummary
	
	dk_call dk_echo
	dk_call dk_echo "Please enter some details about this commit, Then press ENTER."
	dk_call dk_keyboardInput commit_msg
	
	dk_call dk_validate GIT_EXE "dk_call dk_installGit"
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	
	if ! STORE=$(${GIT_EXE} -C ${DKBRANCH_DIR} config credential.helper); then
		echo "ERROR at dk_gitComit.sh line 22"
	fi
	if [ -z "${STORE}" ]; then
		dk_call "${GIT_EXE}" -C ${DKBRANCH_DIR} config --global credential.helper store
		dk_call dk_echo
		dk_call dk_info "git credential.helper is now set to store"
		dk_call dk_echo
	fi
	
	if ! USER_EMAIL=$(${GIT_EXE} -C ${DKBRANCH_DIR} config --global user.email); then
		echo "ERROR at dk_gitComit.sh line 32"
	fi
	if [ -z "${USER_EMAIL}" ]; then
		dk_call dk_echo
		dk_call dk_info "please enter an email address"
		dk_call dk_keyboardInput input
		dk_call "${GIT_EXE}" -C ${DKBRANCH_DIR} config --global user.email "${input}"
		dk_call dk_echo
		dk_call dk_info "git user.email '${input}' saved"
		dk_call dk_echo
	fi
	if ! USER_NAME=$(${GIT_EXE} -C ${DKBRANCH_DIR} config --global user.name); then
		echo "ERROR at dk_gitComit.sh line 44"
	fi
	if [ -z "${USER_NAME}" ]; then
		dk_call dk_echo
		dk_call dk_info "please enter a username"
		dk_call dk_keyboardInput input
		dk_call "${GIT_EXE}" -C ${DKBRANCH_DIR} config --global user.name "${input}"
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
	
	"${GIT_EXE}" -C ${DKBRANCH_DIR} commit -a -m "${commit_msg}" || $(true)
    "${GIT_EXE}" -C ${DKBRANCH_DIR} push
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitCommit
}
