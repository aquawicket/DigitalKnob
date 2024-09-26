#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_getDefaultGateway(rtn_var)
#
#
dk_getDefaultGateway() {
    dk_debugFunc 1
 
	dk_getDefaultGateway DKGATEWAY
	$1="${DKGATEWAY}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_getDefaultGateway "dk_getDefaultGateway" DKGATEWAY
	dk_debug "DKGATEWAY = ${DKGATEWAY}"
}
