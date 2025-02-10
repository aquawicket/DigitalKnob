#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_nativePath(path ret_val)
#
#
dk_nativePath() {
	dk_debugFunc 1 2
	
	dk_call dk_validate HOST_OS "dk_call dk_host_triple"
	if [ "${HOST_OS}" = "win" ]; then
		dk_call dk_getWindowsPath ${1} _winpath_
		#dk_return "${_winpath_//\\/\\\\}"; return
		local ret_val="${2-}"
		dk_call dk_printVar ret_val
		dk_return "${_winpath_}"; return
	else
		local ret_val="${2-}"
		dk_call dk_printVar ret_val
		dk_return "$(dk_readlink -f "${1}")"; return
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_nativePath "/c/Windows/System32" nativePath
	dk_call dk_echo "nativePath = ${nativePath}"
	
	#nativePathB=$(dk_call dk_nativePath "/c/Windows/System32")
	#dk_call dk_echo "nativePathB = ${nativePathB}"
}
