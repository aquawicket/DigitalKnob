#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_stringContains(<string> <substring>)
#
#
dk_stringContains () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	# https://stackoverflow.com/a/8811800/688352
	#_string="$1"
	#_substring="$2"
	#[ "${_string#*"$_substring"}" != "$_string" ]
	
	[ "${1#*"$2"}" != "$1" ]
}





DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###


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
}