#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_getNativePath(path ret_val)
#
#
dk_getNativePath() {
	dk_debugFunc 1 2
	
	dk_call dk_validate HOST_OS "dk_call dk_getHostTriple"
	if [ "${HOST_OS}" = "win" ]; then
		dk_call dk_getWindowsPath ${1} _winpath_
		#dk_call dk_return "${_winpath_//\\/\\\\}"; return
		local ret_val="${2-}"
		dk_call dk_printVar ret_val
		dk_call dk_return "${_winpath_}"; return
	else
		local ret_val="${2-}"
		dk_call dk_printVar ret_val
		dk_call dk_return "$(dk_readlink -f "${1}")"; return
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getNativePath "/c/Windows/System32" nativePath
	dk_call dk_echo "nativePath = ${nativePath}"
	
	#nativePathB=$(dk_call dk_getNativePath "/c/Windows/System32")
	#dk_call dk_echo "nativePathB = ${nativePathB}"
}
