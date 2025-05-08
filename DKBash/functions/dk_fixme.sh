#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_fixme(<message>)
#
#	Print a fixme message to the console
#
#	@msg	- The message to print
#
dk_fixme() {
	dk_debugFunc 0 1
	
	dk_call dk_log FIXME "$1"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_fixme "test dk_fixme message"
}
