#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"


##################################################################################
# dk_onError(<filepath> <lineno>)
#
#  https://stackoverflow.com/a/26261518
#
dk_onError() {
	#dk_debugFunc 2
	#[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	#filepath=${1}
	#lineno=${2}
	
	#export ENABLE_d k_debugFunc=0
	#d k_echo "${red-} Error: ${1}:${2} ${clr-}"
	
	#[ "$(command -v d k_showFileLine)" = "" ]  &&  . ${DKBASH_FUNCTIONS_DIR}/d k_showFileLine.sh
	#d k_showFileLine ${1} ${2}
	#[ "$(command -v d k_stacktrace)" = "" ]  &&  . ${DKBASH_FUNCTIONS_DIR}/d k_stacktrace.sh
	#d k_stacktrace
	
	#dk_call dk_error "### dk_onError: $1:$2 ###"
	#echo "### dk_onError: $1:$2 ###"
	echo "### dk_onError: $(__FILE__ 0):$(__LINE__ 0) ###"
	echo "### dk_onError: $(__FILE__ 1):$(__LINE__ 1) ###"
	echo "### dk_onError: $(__FILE__ 2):$(__LINE__ 2) ###"
	echo "### dk_onError: $(__FILE__ 3):$(__LINE__ 3) ###"
	echo "### dk_onError: $(__FILE__ 4):$(__LINE__ 4) ###"
	echo "### dk_onError: $(__FILE__ 5):$(__LINE__ 5) ###"
	echo "### dk_onError: $(__FILE__ 6):$(__LINE__ 6) ###"
	echo "### dk_onError: $(__FILE__ 7):$(__LINE__ 7) ###"
	echo "### dk_onError: $(__FILE__ 8):$(__LINE__ 8) ###"
	echo "### dk_onError: $(__FILE__ 9):$(__LINE__ 9) ###"
}
trap 'dk_onError ${BASH_SOURCE-} ${LINENO}' ERR




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
funcA(){
	echo "funcA"
	funcC xxx zzz
}

funcB(){
	echo "funcB"
	#
	#
	#
	#
	#
	false
	#
	#
	#
	#
	#
}

funcC(){
	echo "funcC"
}

DKTEST() { 
	funcA test_args 1
	funcB 123 abc
}
