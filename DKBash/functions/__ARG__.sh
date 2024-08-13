#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# __ARG__(arg_number, frame)
#
__ARG__() {
	#dk_debugFunc 1 2
	[ ${#} -eq 0 ] && echo "ERROR: __ARG__() requires at least 1 argument"
	[ ${#} -gt 2 ] && echo "ERROR: __ARG__(): too many arguments"
	[ -z ${2-} ] && local frame=0 || local frame=${2}
	local argN=${1}
	
	#ARGC=$(__ARGC__ $frame)
	ARGC=${BASH_ARGC[${frame}]-}
	[ $(($argN+1)) -gt ${ARGC} ] && echo "ERROR: ARG$argN is out of bounds. ARG(N) is 0 to $((ARGC-1))"
	
	local marker=0
	for (( i=0; i<frame; i++ )); do
		marker=$(($marker + ${BASH_ARGC[${i}]-}))
	done
	local argN=$(($marker+$ARGC-${1}-1))

	local arg=(${BASH_ARGV[${argN}]-})
	dk_return "${arg}"; return
}


test_functionA(){
	#dk_debugFunc 0
	
	echo "${FUNCNAME} FILE = $(__TIME__ 1)"
	echo "${FUNCNAME} FILE = $(__FILE__ 1)"
	echo "${FUNCNAME} LINE = $(__LINE__ 1)"
	echo "${FUNCNAME} FROM = $(__CALLER__ 1)"
	echo "${FUNCNAME} FUNC = $(__FUNCTION__ 1)"
	echo "${FUNCNAME} ARGC = $(__ARGC__ 1)"
	echo "${FUNCNAME} ARGV = $(__ARGV__ 1)"
	echo "${FUNCNAME} ARG0 = $(__ARG__ 0 1)"
	echo "${FUNCNAME} ARG1 = $(__ARG__ 1 1)"
	echo "${FUNCNAME} ARG2 = $(__ARG__ 2 1)"
	echo "${FUNCNAME} ARG3 = $(__ARG__ 3 1)"
	echo "${FUNCNAME} ARG4 = $(__ARG__ 4 1)"
	echo "${FUNCNAME} ARG5 = $(__ARG__ 5 1)"
	#echo "${FUNCNAME} ARG6 = $(__ARG__ 6 1)"	# out of bounds
	test_functionB one two three four
}

test_functionB(){
	#dk_debugFunc
	
	echo "${FUNCNAME} FILE = $(__TIME__ 1)"
	echo "${FUNCNAME} FILE = $(__FILE__ 1)"
	echo "${FUNCNAME} LINE = $(__LINE__ 1)"
	echo "${FUNCNAME} FROM = $(__CALLER__ 1)"
	echo "${FUNCNAME} FUNC = $(__FUNCTION__ 1)"
	echo "${FUNCNAME} ARGC = $(__ARGC__ 1)"
	echo "${FUNCNAME} ARGV = $(__ARGV__ 1)"
	echo "${FUNCNAME} ARG0 = $(__ARG__ 0 1)"
	echo "${FUNCNAME} ARG1 = $(__ARG__ 1 1)"
	echo "${FUNCNAME} ARG2 = $(__ARG__ 2 1)"
	echo "${FUNCNAME} ARG3 = $(__ARG__ 3 1)"
	#echo "${FUNCNAME} ARG4 = $(__ARG__ 4 1)"	# out of bounds
}

###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	#dk_debugFunc
	
	test_functionA abc 123 def 456 ghi 789
}