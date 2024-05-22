#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


################################################################################
# dk_hexToVariable(<hex> <output>)
#
#    reference: https://www.ascii-code.com
#               https://www.gnu.org/software/bash/manual/html_node/ANSI_002dC-Quoting.html#ANSI_002dC-Quoting
#               https://unix.stackexchange.com/a/347410
#
dk_hexToVariable () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	# 0x1b			- prints as  '\x1b'
	# ${2//0x/x}	- removes any starting 0 and changes any 0x to x

	#eval "$2=$(printf '\%s' ${1//0x/x})"
	export $2=$(printf '\%s' ${1//0x/x})
	dk_printVar "${2}"	
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_hexToVariable 0x8C HEX_0x8C
	echo "HEX_0x8C = ${HEX_0x8C}"
	
	printf ${HEX_0x8C}
}