#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"


##################################################################################
# dk_removeFromFile(<string> <file>)
#
#
dk_removeFromFile() {
	dk_debugFunc 2


	sed -i -e "/${1}/d" ${2}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_removeFromFile
}