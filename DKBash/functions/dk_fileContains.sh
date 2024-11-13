#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_fileContains(file, string)
#
#
dk_fileContains() {
	dk_debugFunc 2

	dk_call dk_commandExists grep || dk_call dk_installPackage grep
	grep -q "${2}" "${1}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_fileWrite "fileContains_TEST.txt" "find the needle in the haystack"
	
	if dk_call dk_fileContains "fileContains_TEST.txt" "needle"; then
		dk_call dk_echo "The file contains the string"
	else
		dk_call dk_echo "The file does NOT contain the string"
	fi
	
	if dk_call dk_fileContains "fileContains_TEST.txt" "nope"; then
		dk_call dk_echo "The file contains the string"
	else
		dk_call dk_echo "The file does NOT contain the string"
	fi
}
