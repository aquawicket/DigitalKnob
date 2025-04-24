#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_currentDirectory(<output>)
#
#
dk_currentDirectory() {
	dk_debugFunc 0 1

	_currentDirectory_="${PWD}"

	### return value ###
	dk_call dk_printVar _currentDirectory_
	[ ${#} -gt 1 ] && eval "${2}=${_currentDirectory_}" && return  # return value when using rtn_var parameter 
	dk_return ${_currentDirectory_}; return						  # return value when using command substitution 
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	rtn_var=$(dk_call dk_currentDirectory)
	dk_call dk_info "rtn_var = ${rtn_var}"
}
