#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_toLower(<input> <output>)
#
#
dk_toLower() {
	dk_debugFunc 2

	local output=$(builtin echo "${1}" | tr '[:upper:]' '[:lower:]')
	eval "${2}='${output}'"
	dk_call dk_printVar "${2}"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_toLower "CoNvErT tHiS sTrInG tO aLl LoWeRcAse" lowercase
	echo "lowercase = ${lowercase}"
}
