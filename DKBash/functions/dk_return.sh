#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_return()
#
#
dkret_val () {
	#echo "dkret_val($1, ${@:2})"
	#echo "dkret_val($1, $2)"
	if [ "${1}" = "" ]; then
		#builtin echo "${@:2}"
		builtin echo "${2}"
	else
	#	builtin echo "$1"
		#eval "$1=${@:2}"
		eval "${ret_val}=${2}"
	fi
}

#alias dk_return='[ "${ret_val-}" = "" ] && builtin echo'
alias dk_return='dkret_val "${ret_val-}"'



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_return "return string value"
}