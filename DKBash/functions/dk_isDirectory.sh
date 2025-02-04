#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

####################################################################
# dk_isDirectory(path rtn_var)
#
#
dk_isDirectory () {
	dk_debugFunc 1
	
	if [[ -d ${1} ]]; then
		#if defined ${2} (dk_set ${2} true)
		return $(true)
	fi
	
	#if defined "${2}" (dk_set ${2} true)
	return $(false)
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_isDirectory "C:\Windows" && dk_info "'C:\Windows' is a directory" || dk_info "'C:\Windows' is NOT a directory"
	dk_isDirectory "C:\NotADir" && dk_info "'C:\NotADir' is a directory" || dk_info "'C:\NotADir' is NOT a directory"
}