#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################



##################################################################################
# dk_set(variable, value)
#
#
dk_set() {
	dk_debugFunc 2

	dk_call dk_export ${1} "${2-}"
	dk_call dk_printVar ${1}
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_set myVar "value assigned with dk_set"	
	dk_call dk_echo "myVar = ${myVar}"
}
