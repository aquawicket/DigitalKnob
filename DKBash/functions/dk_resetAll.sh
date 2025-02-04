#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_resetAll()
#
#
dk_resetAll() {
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
		
	dk_call dk_confirm || return
		
#	# make sure script is running from DKBRANCH_DIR
#	if ! [ "${DKSCRIPT_DIR}" = "${DKBRANCH_DIR}" ]; then
#		dk_call dk_echo "${yellow}"
#		dk_call dk_echo "WARNING: this file isn't running from the branch directory"
#		dk_call dk_echo "Is must be in the branch directory to continue."
#		dk_call dk_echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"
#		dk_call dk_echo "${clr}"			
#		dk_call dk_printVar DKBRANCH_DIR
#		return $(false);
#	fi
		
	# Backup main script file to ${DKCACHE_DIR}
	#dk_call dk_delete "${DKCACHE_DIR}/${DKSCRIPT_NAME}"
	dk_call dk_copy "${DKSCRIPT_PATH}" "${DKCACHE_DIR}/${DKSCRIPT_NAME}"
	dk_call dk_cd "${DKCACHE_DIR}"
	dk_call dk_echo "DELETING ${DKBRANCH_DIR} . . . ."
	dk_call dk_delete "${DKBRANCH_DIR}"
	
	dk_call dk_freshRun "${DKCACHE_DIR}/${DKSCRIPT_NAME}"
	
#	dk_call dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development #NO_CONFIRM
	
#	#dk_call dk_info "Restarting ${DKSCRIPT_NAME}. . ."
#	#dk_call dk_sleep 3
	
#	unset DKINIT
#	unset DKHOME_DIR
#	unset DK
#	unset DKF
#	exec /bin/bash "${DKCACHE_DIR}/${DKSCRIPT_NAME}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_resetAll
}