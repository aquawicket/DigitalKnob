<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development


#####################################################################
# dk_sleep(<seconds>)
#
#
dk_sleep() {
	dk_debugFunc 1

<<<<<<< HEAD
	
=======
>>>>>>> Development
	sleep ${1}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

<<<<<<< HEAD
	echo "sleeping for 5 seconds . . ."
	dk_sleep 5
	echo "done"
=======
	seconds=5
	echo "sleeping for ${seconds} seconds . . ."
	dk_sleep ${seconds}
>>>>>>> Development
}