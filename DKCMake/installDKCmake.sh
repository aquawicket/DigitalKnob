#!/bin/sh
[ -z "${DKINIT}" ] && . ../../DKBash/functions/DK.sh

##################################################################################
# installDKCmake()
#
#
installDKCmake() {
	dk_debugFunc 0

	
	dk_validate DKCMAKE_FUNCTIONS_DIR "dk_DKBRANCH_DIR"
	echo "export DKCMAKE_FUNCTIONS_DIR=${DKCMAKE_FUNCTIONS_DIR}" >> /etc/profile
}

installDKCmake