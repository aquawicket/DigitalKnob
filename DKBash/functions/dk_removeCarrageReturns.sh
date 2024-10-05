#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"


##################################################################################
# dk_removeCarrageReturns(<input> <output>)
#
#
dk_removeCarrageReturns() {
	dk_debugFunc 1 2
	
	if [ -n "$2" ]; then 
		eval "$2='${1//$'\r'}'"
		#eval "$2='$(builtin echo "${1}" | tr -d '\r')'"
	else
		builtin echo "${1//$'\r'}"
		#builtin echo $1 | tr -d '\r'
	fi
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	MyVar="String with some '' carage '' returns"
	echo "MyVar = ${MyVar}"
	dk_removeCarrageReturns "${MyVar}" MyVarB
	echo "MyVarB = ${MyVarB}"
}