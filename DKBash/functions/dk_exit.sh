#!/bin/sh
#. ./DK.sh
dk_includeGuard

##################################################################################
# dk_exit()
#
#
dk_exit () {
	dk_debugFunc
	
	echo "dk_exit $*"
	
	# TODO: when open with icon, we can use exec to keep the window open
	#exec $SHELL #$*
	
	# a pure exit is the default
	exit $*
}