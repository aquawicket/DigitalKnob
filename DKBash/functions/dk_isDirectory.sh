#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

####################################################################
# dk_isDirectory(path rtn_var)
#
#
dk_isDirectory () {
	dk_debugFunc
	[ $# -lt 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	if [[ -d $1 ]]; then
		#if defined $2 (dk_set $2 true)
		return ${true}
	fi
	
	#if defined "%~2" (dk_set $2 true)
	return ${false}
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_isDirectory "C:\Windows" && dk_info "'C:\Windows' is a directory" || dk_info "'C:\Windows' is NOT a directory"
	dk_isDirectory "C:\NotADir" && dk_info "'C:\NotADir' is a directory" || dk_info "'C:\NotADir' is NOT a directory"
}