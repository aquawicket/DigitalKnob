#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_callDKCmake(func) args
#
#
dk_callDKCmake() {
	dk_debugFunc 2
	
	### get required variables ###
    ### get ALL_BUT_FIRST_ARGS ###
    ### get LAST_ARG ###
    ### Call DKPowershell function ###
    ### process the return value ###
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_callDKCmake dk_messageBox rtn_var "MessageBox Title" "Testing dk_messageBox"
	dk_debug "rtn_var = ${rtn_var}"
}
