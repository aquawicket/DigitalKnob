#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_command(<>)
#
#
dk_command(){
	dk_debugFunc
	dk_commandExists "${1}" || dk_install ${1}
	dk_commandExists "${1}"  || [$(read -rp '${1} command not found, press enter to exit')] || exit;
	
	dk_echo "$@"
	"$@"
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_command curl --version
}