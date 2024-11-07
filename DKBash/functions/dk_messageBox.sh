#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_messageBox(msg)
#
# https://stackoverflow.com/a/21408784/688352
#
dk_messageBox() {
	dk_debugFunc 1

	echo "${1}"
	# TODO
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_messageBox "testing dk_messageBox.sh"

}
