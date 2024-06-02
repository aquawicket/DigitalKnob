#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_removeCarrageReturns(<input>)
#
#
dk_removeCarrageReturns () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"

	in=$1
	out=$(builtin echo "${in}" | tr -d '\r')
	# carrage returns are removed
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_removeCarrageReturns
}