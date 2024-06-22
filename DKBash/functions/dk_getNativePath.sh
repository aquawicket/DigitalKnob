#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_getNativePath(<path> <ret_val>)
#
#
dk_getNativePath (){
	dk_debugFunc
	[ $# -lt 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	[ $# -gt 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	dk_validate HOST_OS "dk_getHostTriple"
	if [ "${HOST_OS}" = "win" ]; then
		dk_getWindowsPath $1 _winpath_
		#dk_return "${_winpath_//\\/\\\\}"
		local ret_val="${2-}"
		dk_printVar ret_val
		dk_return "${_winpath_}"
	else
		local ret_val="${2-}"
		dk_printVar ret_val
		dk_return "$(readlink -f "$1")"
	fi
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getNativePath "/c/Windows/System32" nativePath
	echo "nativePath = ${nativePath}"
	
	#nativePathB=$(dk_getNativePath "/c/Windows/System32")
	#echo "nativePathB = ${nativePathB}"
}