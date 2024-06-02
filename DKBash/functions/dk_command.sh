#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_command(<>)
#
#
dk_command(){
	[ -z "$(command -v "$1")" ] && dk_install $1
	[ -n "$(command -v "$1")" ] || [$(read -rp '$1 command not found, press enter to exit')] || exit;
	
	dk_echo "$@"
	"$@"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_command curl --version
}