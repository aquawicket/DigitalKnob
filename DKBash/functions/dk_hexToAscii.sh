#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


####################################################################
# dk_hexToAscii(hex, ascii)
#
#
dk_hexToAscii() {
	dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	dk_fixme
	local ascii=$(builtin echo ${1} | xxd -r)

	eval "${2}=${ascii}"
	dk_printVar "${2}"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_hexToAscii 0x55 ascii
	dk_echo "ascii = ${ascii}"
}
