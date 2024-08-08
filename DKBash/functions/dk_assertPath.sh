#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_assertPath(path)
#
dk_assertPath() {
    dk_debugFunc 1
	
	local arg1="${1//[^[:alnum:]]/_}"
	[ ! -z ${!arg1-} ] && _path_=${!arg1-} || _path_=${1-}
	
	if [ ! -e ${_path_} ]; then	
		dk_error "Assertion failed: ${1} : ${_path_} is not found!"
	fi
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_set sys32path "/c/Windows/System32"
	dk_assertPath sys32path
	
	dk_assertPath "/c/NonExistentPath"
}
