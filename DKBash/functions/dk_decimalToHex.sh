#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

####################################################################
# dk_decimalToHex(<decimal> hex)
#
#    reference: https://www.ascii-code.com
#
dk_decimalToHex() {
	dk_debugFunc 2

	
	dk_todo
}


DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######

	myDecimal="45"
	dk_decimalToHex "${myDecimal}" myHex
	dk_printVar myHex
	
}