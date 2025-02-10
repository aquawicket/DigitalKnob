#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_btoa(input, output)
#
#    Encode input to base-64 output
#    https://github.com/base64code/examples
#
dk_btoa() {
	dk_debugFunc 2
	
	[ -e ${1} ] || dk_call dk_error "${1} not found"
	[ -e ${2} ] && dk_call dk_error "${2} already exists and cannot be overwritten"
	
	[ -e ${1} ] && base64 -w 0 "${1}" > "${2}"
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	input="${DKBRANCH_DIR}\DKBuilder.sh"
	output="${DKBRANCH_DIR}\DKBuilder.sh.base64"
	dk_call dk_btoa "${input}" "${output}"
}
