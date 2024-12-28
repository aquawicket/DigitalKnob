#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"


#####################################################################
# dk_sleep(<seconds>)
#
#
dk_sleep() {
	dk_debugFunc 1

	sleep ${1}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	seconds=5
	echo "sleeping for ${seconds} seconds . . ."
	dk_sleep ${seconds}
}