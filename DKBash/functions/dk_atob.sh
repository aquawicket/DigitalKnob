#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_atob(input, output)
#
#    Decode base-64 input to output
#    https://github.com/base64code/examples
#
dk_atob() {
	dk_debugFunc 2
	
	[ -e ${1} ] || dk_call dk_error "${1} not found"
	[ -e ${2} ] && dk_call dk_error "${2} already exists and cannot be overwritten"
	[ -e ${1} ] && base64 -d "${1}" > "${2}"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	input="${DKBRANCH_DIR}\DKBuilder.sh.base64"
	output="${DKBRANCH_DIR}\DKBuilder_decoded.sh"
	dk_call dk_atob "${input}" "${output}"
}