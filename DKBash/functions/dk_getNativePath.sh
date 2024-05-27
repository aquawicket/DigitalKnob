#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_getNativePath(<path>)
#
#
dk_getNativePath () {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	#dk_validate HOST_OS "dk_load dk_getHostTriple; dk_getHostTriple"
	dk_validate HOST_OS "dk_getHostTriple"
	if [ "${HOST_OS}" = "win" ]; then
		dk_getWindowsPath $1 _winpath_
		#echo "${_winpath_//\\/\\\\}"
		echo "${_winpath_}"
	else
		echo "$(readlink -f "$1")"
	fi
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	#dk_getNativePath "/c/Windows/System32" nativePath
	#echo "nativePath = ${nativePath}"
	
	nativePath=$(dk_getNativePath "/c/Windows/System32")
	echo "nativePath = ${nativePath}"
}