#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

################################################################################
# dk_fileToArray(<path> <output>)
#
#  Read lines of a file into an array
#
#  reference: https://stackoverflow.com/a/49042678
#
dk_fileToArray() {
	dk_debugFunc 2

	dk_call dk_todo
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_call dk_fileToArray
}	
