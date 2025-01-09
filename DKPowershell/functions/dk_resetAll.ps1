if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_resetAll){ $dk_resetAll = 1 } else{ return } #include guard

##################################################################################
# dk_resetAll()
#
#
function Global:dk_resetAll() {
	dk_debugFunc 0

	dk_call dk_clearScreen
	dk_call dk_echo
	dk_call dk_echo
	dk_call dk_info "Do you want to reset the entire local repository . . . ?"
	dk_call dk_info "This will delete digitalknob, everything will be reset,"
	dk_call dk_info "and the repository will be re-cloned. All libraries and tools"
	dk_call dk_info "will be re downloaded and rebuild from start. Save any changes"
	dk_call dk_info "you wish to commit or save beforehand."
	dk_call dk_echo
		
	dk_call dk_confirm -or return
		
	# make sure script is running from DKBRANCH_DIR
	if(${DKSCRIPT_DIR} -ne $DKBRANCH_DIR){
		dk_call dk_echo "${yellow}"
		dk_call dk_echo "WARNING: this file isn't running from the branch directory"
		dk_call dk_echo "Is must be in the branch directory to continue."
		dk_call dk_echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"
		dk_call dk_echo "${clr}"			
		dk_call dk_printVar DKBRANCH_DIR
		return ${false};
	}
		
	# Backup main script file to digitalknob/
	#DIGITALKNOB_PARENT_DIR=$(dirname "${DIGITALKNOB_DIR}")
	#rm -r -f "${DIGITALKNOB_PARENT_DIR}/${DKSCRIPT_NAME}"
	#cp "${DKSCRIPT_PATH}" "${DIGITALKNOB_PARENT_DIR}/${DKSCRIPT_NAME}"
	#dk_call dk_echo "DELETING ${DIGITALKNOB_DIR} . . . ."
	#rm -r -f "${DIGITALKNOB_DIR}" 2>nul
	
#	rm -r -f "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"
#	cp "${DKSCRIPT_PATH}" "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"
#	cd "${DIGITALKNOB_DIR}"
#	dk_call dk_echo "DELETING ${DKBRANCH_DIR} . . . ."
#	rm -r -f "${DKBRANCH_DIR}" 2>nul
	
	dk_call dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development #NO_CONFIRM
	
	dk_call dk_info "Restarting ${DKSCRIPT_NAME}. . ."
	dk_call dk_sleep 3
	dk_call dk_reload
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_resetAll
}
