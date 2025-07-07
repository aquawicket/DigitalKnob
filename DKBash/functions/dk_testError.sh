#!/bin/bash
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_testError(args)
#
dk_testError() {
	#dk_debugFunc 0 99
	
	SYNTAX ERROR
	echo "? = $?"
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	#dk_call dk_debugFunc 0

	dk_call dk_testError
}
