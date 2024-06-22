#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_decimalToVariable(<decimal> <output>)
#
dk_decimalToVariable (){
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	dk_decimalToHex $2 hex
	dk_hexToVariable $1 ${hex}
}


DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	myDecimal="32"
	dk_decimalToVariable "${myDecimal}" myVariable
	dk_printVar myVariable

}	