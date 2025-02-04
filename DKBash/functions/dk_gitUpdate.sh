#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_gitUpdate(url, branch, NO_CONFIRM)
#
#
dk_gitUpdate() {

	dk_debugFunc 2 3

	[ -n $1 ] && _url_="$1"    || _url_="https://github.com/aquawicket/DigitalKnob.git"
	[ -n $2 ] && _branch_="$2" || _branch_="Development"
	
	#if ! [ "${3-}" = "NO_CONFIRM" ]; then
	#	dk_call dk_info "Git Update? Any local changes will be lost."
	#	dk_call dk_confirm || return 0
	#fi
	
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	dk_call dk_validate GIT_EXE "dk_call dk_installGit"
	
	if [ ! -d "${DKBRANCH_DIR}/.git" ]; then
		
		# NOTE:		This must cloan and update within the parentheses. rd /s /q "${DKBRANCH_DIR}" removes the current DigitalKnob
		#			folder, leaving the current running batch process abandoned until it's cloned again. It seems like when we are 
		#			in the scope of called batch files, we loose all references to those deleted file once we leave the parentheses.
		#			This includes variables, functions, etc. So to fix this, after we delete the very files our context is running 
		#			from, we must stay in parentheses until those files are restored and updated, or we will lose the context.
		#####################################################################	
		if [ -e "${DKBRANCH_DIR}" ]; then
			####### Backup Branch directory and clone ######
			dk_call dk_copy "${DKBRANCH_DIR}" "${DKBRANCH_DIR}_BACKUP" OVERWRITE
			set "PATH=${DKBRANCH_DIR}_BACKUP\DKBatch\functions;${PATH}"
			rm -r -f "${DKBRANCH_DIR}"
			"${GIT_EXE}" clone ${_url_} "${DKBRANCH_DIR}"
			"${GIT_EXE}" -C ${DKBRANCH_DIR} pull --all
			"${GIT_EXE}" -C ${DKBRANCH_DIR} checkout -- .
			"${GIT_EXE}" -C ${DKBRANCH_DIR} checkout ${_branch_}
			
			if [ ! "${?}" = "0" ]; then
				dk_call dk_echo "Remote has no '${_branch_}' branch. Creating..."
				"${GIT_EXE}" -C ${DKBRANCH_DIR} checkout -b ${_branch_} main
				"${GIT_EXE}" -C ${DKBRANCH_DIR} push --set-upstream origin ${_branch_}
			fi
			return $?
		fi
		#####################################################################
		
		####### Clone into empty branch directory ######
		"${GIT_EXE}" clone ${_url_} "${DKBRANCH_DIR}"
	fi
	
	####### Update ######
	"${GIT_EXE}" -C "${DKBRANCH_DIR}" pull --all
	"${GIT_EXE}" -C "${DKBRANCH_DIR}" checkout -- .
	"${GIT_EXE}" -C "${DKBRANCH_DIR}" checkout "${DKBRANCH}"

	if [ ! "${?}" = "0" ]; then
		dk_call dk_info "Remote has no branch named ${DKBRANCH}. Creating..."
		"${GIT_EXE}" -C "${DKBRANCH_DIR}" checkout -b "${DKBRANCH}" main
		"${GIT_EXE}" -C "${DKBRANCH_DIR}" push --set-upstream origin "${DKBRANCH}"
	fi
	#dk_call ${SUDO_EXE} chmod +x "${DKBRANCH_DIR}"/build
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_debugFunc 0
	
	dk_call dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
}
