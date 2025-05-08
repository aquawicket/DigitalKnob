#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_getFuncName(<output>)
#
#
dk_getFuncName() {
	dk_debugFunc 1

	eval "${1}=${FUNCNAME[1]}"
	dk_call dk_printVar "${1}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getFuncName funcName
	dk_call dk_echo "funcName = ${funcName}"
}
