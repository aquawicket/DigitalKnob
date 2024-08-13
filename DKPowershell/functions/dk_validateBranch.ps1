if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_validateBranch){ $dk_validateBranch = 1 } else{ return }

##################################################################################
# dk_validateBranch()
#
#
function Global:dk_validateBranch() {
	dk_debugFunc 0
	
	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	$FOLDER = dk_call dk_basename "$(pwd)"
	$global:DKBRANCH="Development"
	
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_getDKPaths"
	if(dk_call dk_pathExists "${DIGITALKNOB_DIR}/${FOLDER}/.git"){
		$global:BRANCH=$("${GIT_EXE} rev-parse --abbrev-ref HEAD")
		if("${BRANCH}" -eq "${FOLDER}"){
			$global:DKBRANCH="${FOLDER}"
		}
	}
	dk_call dk_printVar DKBRANCH
	
	$global:DKBRANCH_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}"
	dk_call dk_printVar DKBRANCH_DIR
	
	$global:DKCMAKE_DIR="${DKBRANCH_DIR}/DKCMake"
	dk_call dk_printVar DKCMAKE_DIR
	
	$global:DK3RDPARTY_DIR="${DKBRANCH_DIR}/3rdParty"
	dk_call dk_printVar DK3RDPARTY_DIR
	
	$global:DKIMPORTS_DIR="${DK3RDPARTY_DIR}/_DKIMPORTS"
	dk_call dk_printVar DKIMPORTS_DIR
	
	$global:DKAPPS_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKApps"
	dk_call dk_printVar DKAPPS_DIR
	
	$global:DKPLUGINS_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKPlugins"
	dk_call dk_printVar DKPLUGINS_DIR
	
	$global:DKBASH_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKBash"
	dk_call dk_printVar DKBASH_DIR
	
	$global:DKBATCH_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKBatch"
	dk_call dk_printVar DKBATCH_DIR
	
	$global:DKPOWERSHELL_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKPowershell"
	dk_call dk_printVar DKPOWERSHELL_DIR

	# make sure script is running from DKBRANCH_DIR
	#if ! [ "${DKSCRIPT_DIR}" = "${DKBRANCH_DIR}" ]; then
	#	if ! dk_call dk_pathExists ${DKBRANCH_DIR}/${DKSCRIPT_NAME}; then
	#		dk_call dk_debug "${DKBRANCH_DIR}/${DKSCRIPT_NAME}"
	#		cp ${DKSCRIPT_DIR}/${DKSCRIPT_NAME} ${DKBRANCH_DIR}/${DKSCRIPT_NAME}
	#	fi
	#	dk_call dk_echo
	#	dk_call dk_info "RELOADING SCRIPT TO -> ${DKBRANCH_DIR}/${DKSCRIPT_NAME}"
	#	read -p "Press enter to continue"
	#	dk_call dk_clearScreen
	#	if dk_call dk_pathExists ${DKBRANCH_DIR}/${DKSCRIPT_NAME}; then
	#		rm ${DKSCRIPT_DIR}/${DKSCRIPT_NAME}
	#	fi
	#	${DKBRANCH_DIR}/${DKSCRIPT_NAME}
	#	dk_call dk_exit
	#fi
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validateBranch
}
