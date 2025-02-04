#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

#################################################################################
# dk_keyboardInputTimeout(result, default, timeout)
#
#
dk_keyboardInputTimeout() {
	dk_debugFunc 3
	
	default=$2
	timeout=$3
	
	read -t ${timeout} -e input || $(true)
	input="${input:-${2}}"
	dk_echo "input = ${input}"
	eval $1='"${input}"'
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo "Type some input and press enter when done"
	dk_call dk_keyboardInputTimeout input "default text" 10
	dk_call dk_echo "you typed '${input}'"
}
