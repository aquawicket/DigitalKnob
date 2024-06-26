#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_confirm()
#
#
dk_confirm (){
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"

	dk_echo "${yellow} Are you sure ? [Y/N] ${clr}"
	read -rp $" " REPLY
	dk_echo ""
	dk_echo ""
	#result=$(builtin echo $REPLY | grep "^[Yy]$")
	[ "$REPLY" = "y" ] && return ${true}
	[ "$REPLY" = "Y" ] && return ${true}
	return ${false};
}





DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	if dk_confirm; then 
		echo "the confimation has passed"
	else
		echo "the confimation has failed"
	fi
}