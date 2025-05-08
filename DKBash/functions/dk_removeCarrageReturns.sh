#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################



##################################################################################
# dk_removeCarrageReturns(<input>)
#
#
dk_removeCarrageReturns() {
	dk_debugFunc 0


	in=${1}
	out=$(builtin echo "${in}" | tr -d '\r')
	# carrage returns are removed
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_removeCarrageReturns
}