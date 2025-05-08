#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


################################################################################
# dk_getFiles(<path> <output>)
#
#   reference: https://stackoverflow.com/a/138581
#
dk_getFiles() {
	dk_debugFunc 2
	
	eval "${2}=(${1}/*)" 
	#dk_call dk_printVar "${2}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getFiles /c/Windows/System32 output
}
