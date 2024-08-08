#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

####################################################################
# dk_decimalToAscii(decimal, output)
#
#    reference: https://www.ascii-code.com
#
dk_decimalToAscii() {
	dk_debugFunc 2

	
	dk_decimalToHex ${1} hex
	dk_hexToAscii ${hex} ascii
	
	eval "${2}=${ascii}"
	dk_printVar "${2}"
}




DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc 0
	
	myDecimal="123"
	dk_decimalToAscii "${myDecimal}" ascii
	dk_echo "ascii = ${ascii}"
}