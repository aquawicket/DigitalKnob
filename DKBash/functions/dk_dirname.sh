#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_dirname(path, rtn_var)
#
#    https://en.wikipedia.org/wiki/Dirname
#
dk_dirname (){
	dk_debugFunc
	[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	[ ${#} -gt 2 ] && dk_error "${FUNCNAME}(${#}): too many arguments"
	
	local _dirname_=$(dirname "${1}")
	
	### return value ###
	dk_printVar _dirname_
	[ ${#} -gt 1 ] && eval "${2}=${_dirname_}" && return  # return value when using rtn_var parameter 
	dk_return ${_dirname_}; return						  # return value when using command substitution 
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dirnameA=$(dk_dirname "/path/to/a/filename.txt")
	dk_echo "dirnameA = ${dirnameA}"
	
	dk_dirname "/path/to/a/filename.txt" dirnameB
	dk_echo "dirnameB = ${dirnameB}"
}