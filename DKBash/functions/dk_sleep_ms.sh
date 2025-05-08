#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################



#####################################################################
# dk_sleep_ms(<milliseconds>)
#
#
dk_sleep_ms() {
	dk_debugFunc 1
	
	milliseconds="00${1}"
	#echo "milliseconds = ${milliseconds}"
	seconds="${milliseconds::${#milliseconds}-3}"."${milliseconds:(-3)}"
	#echo "seconds = ${seconds}"
	
	sleep ${seconds}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	milliseconds=3500
	echo "sleeping for ${milliseconds} milliseconds . . ."
	dk_sleep_ms ${milliseconds}
}