#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_fileContains(file, string)
#
#
dk_fileContains() {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
		
	grep -q "$2" "$1"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	echo "find the needle in the haystack" > fileContains_TEST.txt
	
	
	if dk_fileContains "fileContains_TEST.txt" "needle"; then
		echo "The file contains the string"
	else
		echo "The file does NOT contain the string"
	fi
	
	
	if dk_fileContains "fileContains_TEST.txt" "nope"; then
		echo "The file contains the string"
	else
		echo "The file does NOT contain the string"
	fi
}