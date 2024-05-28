#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_onError(<filepath> <lineno>)
#
#  https://stackoverflow.com/a/26261518
#
dk_onError () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	#filepath=$1
	#lineno=$2
	
	export ENABLE_dk_debugFunc=0
	dk_echo "${red-} Error: $1:$2 ${clr-}"
	
	[ "$(command -v dk_showFileLine)" = "" ]  &&  . ${DKBASH_DIR}/functions/dk_showFileLine.sh
	dk_showFileLine $1 $2
	[ "$(command -v dk_stacktrace)" = "" ]  &&  . ${DKBASH_DIR}/functions/dk_stacktrace.sh
	dk_stacktrace
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

DKTEST() { 
	funcA test_args 1
	funcB 123 abc
}