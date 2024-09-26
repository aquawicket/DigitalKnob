#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_getDefaultGateway(rtn_var)
#
#
dk_getDefaultGateway() {
    dk_debugFunc 1
 
	dk_callDKBatch dk_getDefaultGateway rtn_var
	$1="${rtn_var}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_getDefaultGateway DKGATEWAY
	dk_debug "DKGATEWAY = ${DKGATEWAY}"
}
