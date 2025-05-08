#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_getFirstPath(result)
#
#
dk_getFirstPath() {
	dk_debugFunc 1

	eval "${1}=${PATH%%:*}"
	dk_call dk_printVar ${1}
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getFirstPath firstPath
	dk_call dk_echo "firstPath = ${firstPath}"
}
