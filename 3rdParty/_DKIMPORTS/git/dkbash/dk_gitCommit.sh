#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


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
	
	dk_call dk_validate git_exe "dk_call dk_installGit"
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	
	if ! STORE=$(${git_exe} -C ${DKBRANCH_DIR} config credential.helper); then
		echo "ERROR at dk_gitCommit.sh line 35"
	fi
	if [ -z "${STORE}" ]; then
		dk_call "${git_exe}" -C ${DKBRANCH_DIR} config --global credential.helper store
		dk_call dk_echo
		dk_call dk_info "git credential.helper is now set to store"
		dk_call dk_echo
	fi
	
	if ! USER_EMAIL=$(${git_exe} -C ${DKBRANCH_DIR} config --global user.email); then
		echo "ERROR at dk_gitCommit.sh line 45"
	fi
	if [ -z "${USER_EMAIL}" ]; then
		dk_call dk_echo
		dk_call dk_info "please enter an email address"
		dk_call dk_keyboardInput input
		dk_call "${git_exe}" -C ${DKBRANCH_DIR} config --global user.email "${input}"
		dk_call dk_echo
		dk_call dk_info "git user.email '${input}' saved"
		dk_call dk_echo
	fi
	if ! USER_NAME=$(${git_exe} -C ${DKBRANCH_DIR} config --global user.name); then
		echo "ERROR at dk_gitComit.sh line 57"
	fi
	if [ -z "${USER_NAME}" ]; then
		dk_call dk_echo
		dk_call dk_info "please enter a username"
		dk_call dk_keyboardInput input
		dk_call "${git_exe}" -C ${DKBRANCH_DIR} config --global user.name "${input}"
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
	
	"${git_exe}" -C ${DKBRANCH_DIR} commit -a -m "${commit_msg}" || $(true)
	
	if [ -e "${DKStorage_DIR}" ]; then
		### Backup the local repository to a bundle file
		dk_call dk_gitBundle "${DKBRANCH_DIR}" "${DKStorage_DIR}/DigitalKnob.bundle" OVERWRITE
		dk_call dk_sftpUpoad "${DKStorage_DIR}/DigitalKnob.bundle" "/DigitalKnob/DKStorage/DigitalKnob.bundle"
		
		### Backup the local repository to a tar.gz file
		"${git_exe}" -C "${DKBRANCH_DIR}" archive --format=tar.gz Development -0 -o "${DKStorage_DIR}/DigitalKnob.tar.gz"
		# dk_call dk_sftpUpoad "${DKStorage_DIR}/DigitalKnob.tar.gz" "/DigitalKnob/DKStorage/DigitalKnob.tar.gz"
	fi
	
#	### Push to the remote repository
#	set "REPO_URL=https://github.com/aquawicket/DigitalKnob.git"
#	%dk_call% dk_urlExists "%REPO_URL%" && (
#		"%git_exe%" -C "%DKBRANCH_DIR%" remote set-url origin %REPO_URL%
#		"%git_exe%" -C "%DKBRANCH_DIR%" push
#	) || (
#		%dk_call% dk_error "REPO_URL:%REPO_URL% does NOT exist"
#	)	
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_gitCommit
}
