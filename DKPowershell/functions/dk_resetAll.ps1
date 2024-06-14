if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_resetAll){ $dk_resetAll = 1 } else{ return }

##################################################################################
# dk_resetAll()
#
#
function Global:dk_resetAll () {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	
	dk_clearScreen
	dk_echo
	dk_echo
	dk_info "Do you want to reset the entire local repository . . . ?"
	dk_info "This will delete digitalknob, everything will be reset,"
	dk_info "and the repository will be re-cloned. All libraries and tools"
	dk_info "will be redk_downloaded and rebuild from start. Save any changes"
	dk_info "you wish to commit or save beforehand."
	dk_echo
		
	dk_confirm -or return
		
	# make sure script is running from DKBRANCH_DIR
	if($DKSCRIPT_DIR -ne $DKBRANCH_DIR){
		dk_echo "${yellow}"
		dk_echo "WARNING: this file isn't running from the branch directory"
		dk_echo "Is must be in the branch directory to continue."
		dk_echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"
		dk_echo "${clr}"			
		dk_printVar DKBRANCH_DIR
		return ${false};
	}
		
	# Backup main script file to digitalknob/
	#DIGITALKNOB_PARENT_DIR=$(dirname "${DIGITALKNOB_DIR}")
	#rm -r -f "${DIGITALKNOB_PARENT_DIR}/${DKSCRIPT_NAME}"
	#cp "${DKSCRIPT_PATH}" "${DIGITALKNOB_PARENT_DIR}/${DKSCRIPT_NAME}"
	#dk_echo "DELETING ${DIGITALKNOB_DIR} . . . ."
	#rm -r -f "${DIGITALKNOB_DIR}" 2>nul
	
#	rm -r -f "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"
#	cp "${DKSCRIPT_PATH}" "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"
#	cd "${DIGITALKNOB_DIR}"
#	dk_echo "DELETING ${DKBRANCH_DIR} . . . ."
#	rm -r -f "${DKBRANCH_DIR}" 2>nul
	
	dk_gitUpdate #NO_CONFIRM
	
	dk_info "Restarting ${DKSCRIPT_NAME}. . ."
	dk_sleep 3
	dk_reload
}




function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_resetAll
}