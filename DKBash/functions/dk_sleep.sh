#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"


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

	echo "sleeping for 5 seconds . . ."
	dk_sleep 5
	echo "done"
}