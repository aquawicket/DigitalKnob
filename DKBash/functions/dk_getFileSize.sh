#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

################################################################################
# dk_getFileSize(<path> <output>)
#
#
dk_getFileSize() {
	dk_debugFunc 2

	dk_call dk_todo
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getFileSize
}
