#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_fileContains(file, string)
#
#
dk_fileContains() {
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	dk_commandExists grep || dk_install grep
	grep -q "${2}" "${1}"
}



DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc 0
	
	dk_fileWrite "fileContains_TEST.txt" "find the needle in the haystack"
	
	if dk_fileContains "fileContains_TEST.txt" "needle"; then
		dk_echo "The file contains the string"
	else
		dk_echo "The file does NOT contain the string"
	fi
	
	if dk_fileContains "fileContains_TEST.txt" "nope"; then
		dk_echo "The file contains the string"
	else
		dk_echo "The file does NOT contain the string"
	fi
}
