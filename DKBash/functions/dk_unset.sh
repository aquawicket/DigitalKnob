#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_unset(variable)
#
#
dk_unset() {
	dk_debugFunc 1

	builtin unset ${1}
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_set myVar "initial value assigned with dk_unset"
	dk_call dk_echo "myVar = ${myVar}"
	dk_call dk_unset myVar
	dk_call dk_echo "myVar = ${myVar-}"
}
