#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

####################################################################
# dk_decimalToAscii(decimal, output)
#
#    reference: https://www.ascii-code.com
#
dk_decimalToAscii() {
	dk_debugFunc 2

	dk_call dk_decimalToHex ${1} hex
	dk_call dk_hexToAscii ${hex} ascii
	
	eval "${2}=${ascii}"
	dk_call dk_printVar "${2}"
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myDecimal="123"
	dk_call dk_decimalToAscii "${myDecimal}" ascii
	dk_call dk_echo "ascii = ${ascii}"
}
