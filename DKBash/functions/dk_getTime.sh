#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_getTime(RTN_time)
#
#
dk_getTime() {
	dk_debugFunc 1
	RTN_time="${ARGV0-}"
	
	current_time=$(date +"%H-%M-%S")
	eval "${1}=${current_time}"
	
#if DEBUG_CMAKE
	dk_call dk_echo "RTN_time = ${current_time}"
#fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getTime myTime
	dk_call dk_echo "myTime = ${myTime}"
}
