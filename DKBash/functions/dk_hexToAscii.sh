#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

####################################################################
# dk_hexToAscii(hex, ascii)
#
#
dk_hexToAscii() {
	dk_debugFunc 2

	dk_call dk_fixme
	local ascii=$(builtin echo ${1} | xxd -r)

	eval "${2}=${ascii}"
	dk_call dk_printVar "${2}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_hexToAscii 0x55 ascii
	dk_call dk_echo "ascii = ${ascii}"
}
