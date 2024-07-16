#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_basename(path, rtn_var)
#
#	https://en.wikipedia.org/wiki/Basename
#
dk_basename() {
	dk_debugFunc
	[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	[ ${#} -gt 2 ] && dk_error "${FUNCNAME}(${#}): too many arguments"
	
	local _basename_=$(basename "${1}")
	
	### return value ###
	#dk_printVar _basename_ 	# ERROR: causes infinate loop
	[ ${#} -gt 1 ] && eval "${2}=${_basename_}" && return	# return value when using rtn_var parameter 
	dk_return ${_basename_}; return					        # return value when using command substitution 
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	basenameA=$(dk_basename "/path/to/a/filename.txt")
	dk_echo "basenameA = ${basenameA}"
	
	dk_basename "/path/to/a/filename.txt" basenameB
	dk_echo "basenameB = ${basenameB}"
}
