#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_exit()
#
#
dk_exit () {
	dk_debugFunc
	
	echo "dk_exit $*"
	
	# TODO: when open with icon, we can use exec to keep the window open
	echo "SHLVL = $SHLVL"
	exec $SHELL & echo "SHLVL = $SHLVL"
	
	# a pure exit is the default
	#exit $*
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_exit
}