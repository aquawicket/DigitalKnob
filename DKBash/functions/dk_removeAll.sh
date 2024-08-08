#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_removeAll()
#
#
dk_removeAll() {
	dk_debugFunc 0

	
	dk_clearScreen
	dk_echo
	dk_echo
	dk_info "Do you want to delete the entire local repository . . . ?"
	dk_info "This will delete the local digitalknob branch repository"
	dk_info "Save any un-commited changes first."
	dk_echo
		
	dk_confirm || return
		
	# make sure script is running from DKBRANCH_DIR
	if ! [ "${DKSCRIPT_DIR}" = "${DKBRANCH_DIR}" ]; then
		dk_echo "${yellow}"
		dk_echo "WARNING: this file isn't running from the branch directory"
		dk_echo "Is must be in the branch directory to continue."
		dk_echo "${clr}"
        dk_printVar DKSCRIPT_DIR
		dk_printVar DKBRANCH_DIR
		return ${false};
	fi
		
	# Backup main script file to digitalknob/
	rm -r -f "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"
	cp "${DKSCRIPT_PATH}" "${DIGITALKNOB_DIR}/${DKSCRIPT_NAME}"
		
	dk_echo "DELETING ${DKBRANCH_DIR} . . . ."
	rm -r -f "${DKBRANCH_DIR}" 2>/dev/null
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######

	dk_removeAll
}