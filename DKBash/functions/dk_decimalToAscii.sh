#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

####################################################################
# dk_decimalToAscii(<decimal> <output>)
#
#    reference: https://www.ascii-code.com
#
dk_decimalToAscii () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	dk_decimalToHex ${1} hex
	dk_hexToAscii ${hex} ascii
	
	eval "$2=${ascii}"
	dk_printVar "${2}"
}




DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	myDecimal="123"
	dk_decimalToAscii "${myDecimal}" ascii
	echo "ascii = ${ascii}"

}