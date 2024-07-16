#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_chown(path)
#
dk_chown() {
	dk_debugFunc
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	
	[ -n "${USER-}" ] && DKUSERNAME=${USER} || DKUSERNAME=${USERNAME}	
	${dksudo} chown -R ${DKUSERNAME} "${1}"
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_validate DIGITALKNOB_DIR "dk_getDKPaths"
	dk_chown ${DIGITALKNOB_DIR}
}