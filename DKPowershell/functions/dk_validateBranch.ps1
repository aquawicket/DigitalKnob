if(!$DKINIT){ .${env:DKPOWERSHELL_FUNCTIONS_DIR}\DK.ps1 }
if(!$dk_validateBranch){ $dk_validateBranch = 1 } else{ return }

##################################################################################
# dk_validateBranch()
#
#
function Global:dk_validateBranch() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	$FOLDER = dk_basename "$(pwd)"
	$global:DKBRANCH="Development"
	
	dk_validate DIGITALKNOB_DIR "dk_getDKPaths"
	if(dk_pathExists "${DIGITALKNOB_DIR}/${FOLDER}/.git"){
		$global:BRANCH=$("${GIT_EXE} rev-parse --abbrev-ref HEAD")
		if("${BRANCH}" -eq "${FOLDER}"){
			$global:DKBRANCH="${FOLDER}"
		}
	}
	dk_printVar DKBRANCH
	
	$global:DKBRANCH_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}"
	dk_printVar DKBRANCH_DIR
	
	$global:DKCMAKE_DIR="${DKBRANCH_DIR}/DKCMake"
	dk_printVar DKCMAKE_DIR
	
	$global:DK3RDPARTY_DIR="${DKBRANCH_DIR}/3rdParty"
	dk_printVar DK3RDPARTY_DIR
	
	$global:DKIMPORTS_DIR="${DK3RDPARTY_DIR}/_DKIMPORTS"
	dk_printVar DKIMPORTS_DIR
	
	$global:DKAPPS_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKApps"
	dk_printVar DKAPPS_DIR
	
	$global:DKPLUGINS_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKPlugins"
	dk_printVar DKPLUGINS_DIR
	
	$global:DKBASH_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKBash"
	dk_printVar DKBASH_DIR
	
	$global:DKBATCH_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKBatch"
	dk_printVar DKBATCH_DIR
	
	$global:DKPOWERSHELL_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKPowershell"
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




function Global:DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc
	
	
	dk_validateBranch
}