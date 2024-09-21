#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_resetAll()
#
#
dk_resetAll() {
	dk_debugFunc 0

	
	dk_clearScreen
	dk_echo
	dk_echo
	dk_info "Do you want to reset the entire local repository . . . ?"
	dk_info "This will delete digitalknob, everything will be reset,"
	dk_info "and the repository will be re-cloned. All libraries and tools"
	dk_info "will be re downloaded and rebuild from start. Save any changes"
	dk_info "you wish to commit or save beforehand."
	dk_echo
		
	dk_confirm || return
		
	# make sure script is running from DKBRANCH_DIR
	if ! [ "${DKSCRIPT_DIR}" = "${DKBRANCH_DIR}" ]; then
		dk_echo "${yellow}"
		dk_echo "WARNING: this file isn't running from the branch directory"
		dk_echo "Is must be in the branch directory to continue."
		dk_echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"
		dk_echo "${clr}"			
		dk_printVar DKBRANCH_DIR
		return $(false);
	fi
		
	# Backup main script file to digitalknob/
	#DIGITALKNOB_PARENT_DIR=$(dk_dirname "${DIGITALKNOB_DIR}")
	#rm -r -f "${DIGITALKNOB_PARENT_DIR}/${DKSCRIPT_NAME}"
	#cp "${DKSCRIPT_PATH}" "${DIGITALKNOB_PARENT_DIR}/${DKSCRIPT_NAME}"
	#dk_echo "DELETING ${DIGITALKNOB_DIR} . . . ."
	#rm -r -f "${DIGITALKNOB_DIR}" 2>/dev/null
	
	rm -r -f "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"
	cp "${DKSCRIPT_PATH}" "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"
	cd "${DIGITALKNOB_DIR}"
	dk_echo "DELETING ${DKBRANCH_DIR} . . . ."
	rm -r -f "${DKBRANCH_DIR}" 2>/dev/null
	
	dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development #NO_CONFIRM
	
	dk_info "Restarting ${DKSCRIPT_NAME}. . ."
	dk_sleep 3
	dk_reload
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_resetAll
}