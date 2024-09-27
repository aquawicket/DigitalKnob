#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_toUpper(<input> <output>)
#
#
dk_toUpper() {
	dk_debugFunc 2

	local output=$(builtin echo "${1}" | tr '[:lower:]' '[:upper:]')
	eval "${2}='${output}'"
	dk_call dk_printVar "${2}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_toUpper "CoNvErT tHiS sTrInG tO aLl UpPeRcAsE" uppercase
	echo "uppercase = ${uppercase}"
}
