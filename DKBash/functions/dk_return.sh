#!/bin/sh
#echo "dirname 0/DK.sh = $(dirname ${0})/DK.sh"
[ -z "${DKINIT-}" ] && . "$(dirname ${0})/DK.sh";
#[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR}/DK.sh"


##################################################################################
# dk_return()
#
#

alias dk_return='ret_val "${ret_val-}"'
ret_val (){
	if [ "${1-}" = "" ]; then
		builtin echo "${2-}"
		#trap '' EXIT
		#exit
	else
		eval "${ret_val-}='${2-}'"
		unset ret_val
	fi
}





DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_return "return string value"; return
}