#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


####################################################################
# dk_hexToDecimal(hex output)
#
#    reference: https://www.ascii-code.com
#               https://stackoverflow.com/a/13280173
#
dk_hexToDecimal() {
	dk_debugFunc 2

	eval "${2}=$(printf "%d\n" ${1})"
	dk_call dk_printVar "${2}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_hexToDecimal 0x1b decimal
	dk_call dk_echo "decimal = ${decimal}"
}
