#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_getNativePath(<path> <ret_val>)
#
#
dk_getNativePath () {
	dk_debugFunc
	echo "dk_getNativePath($1, ${2-})"
	local ret_val="${2-}"
	
	#if [ "${2-}" = "" ]; then
		dk_return "substitution"
	#else
	#	dk_return "variable"
	#fi

	#[ $# -ne 1 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	#dk_validate HOST_OS "dk_load dk_getHostTriple; dk_getHostTriple"
#	dk_validate HOST_OS "dk_getHostTriple"
#	if [ "${HOST_OS}" = "win" ]; then
#		dk_getWindowsPath $1 _winpath_
#		#dk_return "${_winpath_//\\/\\\\}"
#		dk_return "${_winpath_}"
#	else
#		dk_return "$(readlink -f "$1")"
#	fi
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getNativePath "/c/Windows/System32" nativePath
	echo "nativePath = ${nativePath}"
	
	nativePathB=$(dk_getNativePath "/c/Windows/System32")
	echo "nativePathB = ${nativePathB}"
}