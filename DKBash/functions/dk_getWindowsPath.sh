#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_getWindowsPath(<path> <output>)
#
#
dk_getWindowsPath() {
	dk_debugFunc 2

	local _winpath_=$(cygpath -w "${1}")
	eval "${2}=${_winpath_//\\/\\\\}"
	#eval "${2}=${_winpath_}"
	dk_call dk_printVar ${2}
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getWindowsPath "/c/Windows/System32" windowsPath
	dk_call dk_echo "windowsPath = ${windowsPath}"
}
