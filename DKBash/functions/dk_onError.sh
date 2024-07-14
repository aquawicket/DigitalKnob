#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_onError(<filepath> <lineno>)
#
#  https://stackoverflow.com/a/26261518
#
dk_onError (){
	#dk_debugFunc
	[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	#filepath=${1}
	#lineno=${2}
	
	#export ENABLE_d k_debugFunc=0
	#d k_echo "${red-} Error: ${1}:${2} ${clr-}"
	
	#[ "$(command -v d k_showFileLine)" = "" ]  &&  . ${DKBASH_FUNCTIONS_DIR}/d k_showFileLine.sh
	#d k_showFileLine ${1} ${2}
	#[ "$(command -v d k_stacktrace)" = "" ]  &&  . ${DKBASH_FUNCTIONS_DIR}/d k_stacktrace.sh
	#d k_stacktrace
	
	dk_error "### dk_onError ###"
}
trap 'dk_onError $BASH_SOURCE $LINENO' ERR




####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
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

DKTEST (){ 
	funcA test_args 1
	funcB 123 abc
}