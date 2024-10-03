#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_callDKCmake(func) args
#
#
dk_callDKCmake() {
	dk_debugFunc 2
	
	# TODO
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_callDKCmake dk_messageBox rtn_var "MessageBox Title" "Testing dk_messageBox"
	dk_debug "rtn_var = ${rtn_var}"
}
