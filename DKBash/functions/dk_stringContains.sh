#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


##################################################################################
# dk_stringContains(<string> <substring>)
#
#
dk_stringContains () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	# https://stackoverflow.com/a/8811800/688352
	string=$1
	substring=$2
	[ "${string#*"$substring"}" != "$string" ]	
}





################################ DKTEST #########################################
[ -n "$DKTEST" ] && {


	if dk_stringContains "1one1" "one"; then
		echo "1one1 contains one"
	else
		echo "1one1 does not contains one"
	fi

	if dk_stringContains "2two2" "tow"; then
		echo "2two2 contains tow"
	else
		echo "2two2 does not contain tow"
	fi
	
	
} && exec $SHELL