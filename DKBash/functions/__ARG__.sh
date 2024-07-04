#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# __ARG__(arg_number, frame)
#
__ARG__ (){
	[ $# -eq 0 ] && echo "ERROR: __ARG__() requires at least 1 argument"
	[ $# -gt 2 ] && echo "ERROR: __ARG__(): too many arguments"
	[ -z ${2-} ] && local frame=0 || local frame=$2
	local argN=$1
	
	ARGC=$(__ARGC__ $frame)
	[ $(($argN+1)) -gt ${ARGC} ] && echo "ERROR: argN:$argN out of bounds. ARGC is $ARGC"
	
	local marker=0
	for (( i=0; i<frame; i++ )); do
		marker=$(($marker + ${BASH_ARGC[${i}]-}))
	done
	local argN=$(($marker+$1))

	local arg=(${BASH_ARGV[${argN}]-})
	dk_return "${arg}"; return
}


test_function(){
	echo "ARG0-1 = $(__ARG__ 0 1)"
	echo "ARG1-1 = $(__ARG__ 1 1)"
}

DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	test_function abc 123
}