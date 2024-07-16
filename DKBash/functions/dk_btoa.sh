#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_btoa(input, output)
#
#    Encode input to base-64 output
#    https://github.com/base64code/examples
#
dk_btoa() {
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	[ -e ${1} ] || dk_error "${1} not found"
	[ -e ${2} ] && dk_error "${2} already exists and cannot be overwritten"
	
	[ -e ${1} ] && base64 -w 0 "${1}" > "${2}"
}





DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_validate DKBRANCH_DIR "dk_validateBranch"
	input="${DKBRANCH_DIR}\DKBuilder.sh"
	output="${DKBRANCH_DIR}\DKBuilder.sh.base64"
	dk_btoa "${input}" "${output}"
}