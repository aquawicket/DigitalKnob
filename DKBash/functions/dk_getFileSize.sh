#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

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
