#!/bin/sh
[ -z "${DKINIT}" ] && . ../../DKBash/functions/DK.sh

##################################################################################
# installDKCmake()
#
#
installDKCmake (){
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	dk_validate DKCMAKE_FUNCTIONS_DIR "dk_validateBranch"
	echo "export DKCMAKE_FUNCTIONS_DIR=${DKCMAKE_FUNCTIONS_DIR}" >> /etc/profile
}

installDKCmake