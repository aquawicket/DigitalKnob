#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################



#####################################################################
# dk_sleep(<seconds>)
#
#
dk_sleep() {
	dk_debugFunc 1

	sleep ${1}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	seconds=5
	echo "sleeping for ${seconds} seconds . . ."
	dk_sleep ${seconds}
}