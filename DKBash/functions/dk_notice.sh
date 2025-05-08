#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_notice(message)
#
#	Print a notice message to the console
#
#	@msg	- The message to print
#
dk_notice() {
	dk_debugFunc 1
	
	dk_call dk_log NOTICE "${1-}"
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_notice "test dk_notice message"
}
