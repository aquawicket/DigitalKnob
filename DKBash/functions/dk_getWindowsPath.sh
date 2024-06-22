#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_getWindowsPath(<path> <output>)
#
#
dk_getWindowsPath (){
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	_winpath_=$(cygpath -w "$1")
	eval "$2=${_winpath_//\\/\\\\}"
	dk_printVar $2
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_getWindowsPath "/c/Windows/System32" windowsPath
	echo "windowsPath = ${windowsPath}"
}