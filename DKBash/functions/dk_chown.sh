#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_chown(path)
#
dk_chown() {
	dk_debugFunc 1
	[ ${#} -ne 1 ] && dk_call dk_error "${FUNCNAME}(${#}): not enough arguments"
	
	[ -n "${USER-}" ] && DKUSERNAME=${USER} || DKUSERNAME=${USERNAME}	
	${dksudo} chown -R ${DKUSERNAME} "${1}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_getDKPaths"
	dk_call dk_chown ${DIGITALKNOB_DIR}
}
