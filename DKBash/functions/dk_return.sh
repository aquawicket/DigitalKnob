#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_return()
#
#
alias dk_return='ret_val "${ret_val-}"'
ret_val () {
	if [ "${1}" = "" ]; then
		builtin echo "${2}"
	else
		eval "${ret_val}='${2}'"
		unset ret_val
	fi
}



#alias dk_return='ret_val "${ret_val-}"'
##alias dk_return='ret_val '
#ret_val () {
#	#echo "ret_val($1, ${2-})"
#	if [ "${1}" = "" ]; then
#		builtin echo "${2-}"
#	else
#		#local ret_val="${1}"
#		eval "${ret_val}='${2-}'"
#		unset ret_val
#	fi
#}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_return "return string value"
}