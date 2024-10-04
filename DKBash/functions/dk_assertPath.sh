#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

################################################################################
# dk_assertPath(path)
#
dk_assertPath() {
    dk_debugFunc 1
	
    [ -e ${1-} ] && return 0
    [ -e ${!1} ] && return 0
    
	#local arg1="${path//[^[:alnum:]]/_}"
	#[ ! -z ${!arg1-} ] && _path_=${!arg1-} || _path_=${1-}
	
	dk_call dk_error "Assertion failed: ${1} : ${_path_} is not found!"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_set sys32path "/c/Windows/System32"
	dk_call dk_assertPath sys32path
	
	dk_call dk_assertPath "/c/NonExistentPath"
}
