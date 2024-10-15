#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_chown(path)
#
dk_chown() {
	dk_debugFunc 1
	
	[ -n "${USER-}" ] && DKUSERNAME=${USER} || DKUSERNAME=${USERNAME}	
	${SUDO_EXE} chown -R ${DKUSERNAME} "${1}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR"
	dk_call dk_chown ${DIGITALKNOB_DIR}
}
