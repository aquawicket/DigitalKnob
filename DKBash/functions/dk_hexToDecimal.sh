#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


####################################################################
# dk_hexToDecimal(hex output)
#
#    reference: https://www.ascii-code.com
#               https://stackoverflow.com/a/13280173
#
dk_hexToDecimal() {
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	eval "${2}=$(printf "%d\n" ${1})"
	dk_printVar "${2}"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_hexToDecimal 0x1b decimal
	dk_echo "decimal = ${decimal}"
}