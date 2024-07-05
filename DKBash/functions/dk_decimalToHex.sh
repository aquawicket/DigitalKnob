#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

####################################################################
# dk_decimalToHex(<decimal> hex)
#
#    reference: https://www.ascii-code.com
#
dk_decimalToHex (){
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	dk_todo
}


DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	myDecimal="45"
	dk_decimalToHex "${myDecimal}" myHex
	dk_printVar myHex
	
}