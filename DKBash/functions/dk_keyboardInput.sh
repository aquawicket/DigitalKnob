#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_keyboardInput(variable)
#
#
dk_keyboardInput() {
	dk_debugFunc 1
	
	#dk_call dk_unset ${1-}
    read input
	dk_echo "input = ${input-}"
	eval $1='"${input}"'
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo "Type some input and press enter when done"
	dk_call dk_keyboardInput input
	dk_call dk_echo "you typed '${input}'"
}
