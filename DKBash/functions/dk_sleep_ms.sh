#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"


#####################################################################
# dk_sleep_ms(<milliseconds>)
#
#
dk_sleep_ms() {
	dk_debugFunc 1
	
	milliseconds="00${1}"
	#echo "milliseconds = ${milliseconds}"
	seconds="${milliseconds::${#milliseconds}-3}"."${milliseconds:(-3)}"
	#echo "seconds = ${seconds}"
	
	sleep ${seconds}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	milliseconds=3500
	echo "sleeping for ${milliseconds} milliseconds . . ."
	dk_sleep_ms ${milliseconds}
}