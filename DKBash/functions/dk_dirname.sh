#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_dirname(path, rtn_var)
#
#    https://en.wikipedia.org/wiki/Dirname
#
dk_dirname() {
	dk_debugFunc 1 2
	
	local _dirname_=$(dirname "${1}")
	
	### return value ###
	dk_call dk_printVar _dirname_
	[ ${#} -gt 1 ] && eval "${2}=${_dirname_}" && return  # return value when using rtn_var parameter 
	dk_return ${_dirname_}; return						  # return value when using command substitution 
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dirnameA=$(dk_call dk_dirname "/path/to/a/filename.txt")
	dk_call dk_echo "dirnameA = ${dirnameA}"
	
	dk_call dk_dirname "/path/to/a/filename.txt" dirnameB
	dk_call dk_echo "dirnameB = ${dirnameB}"
}
