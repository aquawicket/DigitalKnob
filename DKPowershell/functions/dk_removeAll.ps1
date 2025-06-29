if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_removeAll_ps1){ $dk_removeAll_ps1 = 1; } else{ return; } #include guard

##################################################################################
# dk_removeAll()
#
#
function Global:dk_removeAll() {
	dk_debugFunc 0;

	dk_call dk_clearScreen
	dk_call dk_echo "\n";
	dk_call dk_echo "\n";
	dk_call dk_info "Do you want to delete the entire local repository . . . ?\n";
	dk_call dk_info "This will delete the local DigitalKnob branch repository\n";
	dk_call dk_info "Save any un-commited changes first.\n";
	dk_call dk_echo "\n";
		
	dk_call dk_confirm -or return
		
	# make sure script is running from DKBRANCH_DIR
	if(${DKSCRIPT_DIR} -ne $DKBRANCH_DIR){
		dk_call dk_echo "${yellow}\n";
		dk_call dk_echo "WARNING: this file isn't running from the branch directory\n";
		dk_call dk_echo "Is must be in the branch directory to continue.\n";
		dk_call dk_echo "${clr}\n";
        dk_call dk_printVar DKSCRIPT_DIR
		dk_call dk_printVar DKBRANCH_DIR
		return ${false};
	}
		
	# Backup main script file to DigitalKnob/
#	rm -r -f "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"
#	cp "${DKSCRIPT_PATH}" "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"
		
#	dk_call dk_echo "DELETING ${DKBRANCH_DIR} . . . .\n";
#	rm -r -f "${DKBRANCH_DIR}" 2>nul
}










###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_removeAll;
}
