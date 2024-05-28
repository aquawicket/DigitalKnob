#!/bin/sh
[ -z "${DKINIT}" ] && ( . "$(dirname $0)/DK.sh" )


#!!!!!!!!!!!!!!!!   FIXME  !!!!!!!!!!!!!!!!!!!!!!!

##################################################################################
# dk_onSigusr1()
#
#
dk_onSigusr1 () {
	dk_debugFunc
	echo "dk_onSigusr1"
	
	read -rp 'Press enter to continue...' key
}
trap 'dk_onSigusr1' USR1





####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
DKTEST() { 
	echo "sending USR1  signal . . ."
	
	pid=$!

	trap 'echo received SIGUSR1' USR1
	kill -s USR1 $$
	wait $pid

	read -rp 'Press enter to continue...' key
}