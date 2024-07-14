#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_validateBranch()
#
#
dk_validateBranch (){
	dk_debugFunc
	[ ${#} -ne 0 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"

	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	FOLDER="$(dk_basename $(pwd))"
	DKBRANCH="Development"
	
	dk_validate DIGITALKNOB_DIR "dk_getDKPaths"
	if dk_pathExists "${DIGITALKNOB_DIR}"/"${FOLDER}"/.git; then
		BRANCH="$(${GIT_EXE} rev-parse --abbrev-ref HEAD)"
		if [ "${BRANCH}" = "${FOLDER}" ]; then
			DKBRANCH="${FOLDER}"
		fi
	fi
	dk_printVar DKBRANCH
	
	DKBRANCH_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}"
	dk_printVar DKBRANCH_DIR
	
	DKCMAKE_DIR="${DKBRANCH_DIR}/DKCMake"
	dk_printVar DKCMAKE_DIR
		DKCMAKE_FUNCTIONS_DIR="${DKCMAKE_DIR}/functions"
		dk_printVar DKCMAKE_FUNCTIONS_DIR
	
	DK3RDPARTY_DIR="${DKBRANCH_DIR}/3rdParty"
	dk_printVar DK3RDPARTY_DIR
	
	DKIMPORTS_DIR="${DK3RDPARTY_DIR}/_DKIMPORTS"
	dk_printVar DKIMPORTS_DIR
	
	DKAPPS_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKApps"
	dk_printVar DKAPPS_DIR
	
	DKPLUGINS_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKPlugins"
	dk_printVar DKPLUGINS_DIR
	
	DKBASH_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKBash"
	dk_printVar DKBASH_DIR
	
	DKBATCH_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKBatch"
	dk_printVar DKBATCH_DIR
	
	DKPOWERSHELL_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKPowershell"
	dk_printVar DKPOWERSHELL_DIR

	# make sure script is running from DKBRANCH_DIR
	#if ! [ "${DKSCRIPT_DIR}" = "${DKBRANCH_DIR}" ]; then
	#	if ! dk_pathExists ${DKBRANCH_DIR}/${DKSCRIPT_NAME}; then
	#		dk_debug "${DKBRANCH_DIR}/${DKSCRIPT_NAME}"
	#		cp ${DKSCRIPT_DIR}/${DKSCRIPT_NAME} ${DKBRANCH_DIR}/${DKSCRIPT_NAME}
	#	fi
	#	dk_echo
	#	dk_info "RELOADING SCRIPT TO -> ${DKBRANCH_DIR}/${DKSCRIPT_NAME}"
	#	read -p "Press enter to continue"
	#	dk_clearScreen
	#	if dk_pathExists ${DKBRANCH_DIR}/${DKSCRIPT_NAME}; then
	#		rm ${DKSCRIPT_DIR}/${DKSCRIPT_NAME}
	#	fi
	#	${DKBRANCH_DIR}/${DKSCRIPT_NAME}
	#	dk_exit
	#fi
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_validateBranch
}