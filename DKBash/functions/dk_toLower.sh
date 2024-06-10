#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_toLower(<input> <output>)
#
#
dk_toLower() {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"

	echo "1 = $1"
	local output=$(builtin echo "$1" | tr '[:upper:]' '[:lower:]')
	echo "output = $output"
	eval "$2='${output}'"
	dk_printVar "${2}"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_toLower "CoNvErT tHiS sTrInG tO aLl LoWeRcAse" lowercase
	echo "lowercase = ${lowercase}"
}