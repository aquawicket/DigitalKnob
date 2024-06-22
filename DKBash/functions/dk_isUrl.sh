#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_isUrl(string)
#
#
dk_isUrl (){
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	dk_stringContains "$1" "://" && return ${true}
	return ${false}
}



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	test_url="http://www.aquawicket.com"
	
	if dk_isUrl "${test_url}"; then
		echo "variable is a url"
	else
		echo "variable is NOT a url";
	fi
	
	
	test_not_url="readme.txt"
	if dk_isUrl "${test_not_url}"; then
		echo "variable is a url"
	else
		echo "variable is NOT a url";
	fi
}