#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_getDefaultGateway(rtn_var)
#
#
dk_getDefaultGateway() {
    dk_debugFunc 1
 
	dk_call dk_callDKBatch dk_getDefaultGateway rtn_var
	eval "${1}=${rtn_var}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_getDefaultGateway DKGATEWAY
	echo "DKGATEWAY = ${DKGATEWAY}"
}