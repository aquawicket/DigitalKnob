#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

####################################################################
# dk_decimalToHex(<decimal> hex)
#
#    reference: https://www.ascii-code.com
#
dk_decimalToHex() {
	dk_debugFunc 2

	dk_call dk_todo
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	myDecimal="45"
	dk_call dk_decimalToHex "${myDecimal}" myHex
	dk_call dk_printVar myHex
}
