#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"


##################################################################################
# dk_removeCarrageReturns(<input>)
#
#
dk_removeCarrageReturns() {
	dk_debugFunc 0


	in=${1}
	out=$(builtin echo "${in}" | tr -d '\r')
	# carrage returns are removed
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_removeCarrageReturns
}