<<<<<<< HEAD
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_removeAll){ $dk_removeAll = 1 } else{ return }
=======
if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_removeAll){ $dk_removeAll = 1 } else{ return } #include guard
>>>>>>> Development

##################################################################################
# dk_removeAll()
#
#
function Global:dk_removeAll() {
	dk_debugFunc 0

	dk_call dk_clearScreen
	dk_call dk_echo
	dk_call dk_echo
	dk_call dk_info "Do you want to delete the entire local repository . . . ?"
	dk_call dk_info "This will delete the local digitalknob branch repository"
	dk_call dk_info "Save any un-commited changes first."
	dk_call dk_echo
		
	dk_call dk_confirm -or return
		
	# make sure script is running from DKBRANCH_DIR
	if(${DKSCRIPT_DIR} -ne $DKBRANCH_DIR){
		dk_call dk_echo "${yellow}"
		dk_call dk_echo "WARNING: this file isn't running from the branch directory"
		dk_call dk_echo "Is must be in the branch directory to continue."
		dk_call dk_echo "${clr}"
        dk_call dk_printVar DKSCRIPT_DIR
		dk_call dk_printVar DKBRANCH_DIR
		return ${false};
	}
		
	# Backup main script file to digitalknob/
#	rm -r -f "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"
#	cp "${DKSCRIPT_PATH}" "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"
		
#	dk_call dk_echo "DELETING ${DKBRANCH_DIR} . . . ."
#	rm -r -f "${DKBRANCH_DIR}" 2>nul
}










###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_removeAll
}
