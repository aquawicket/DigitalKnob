#!/bin/sh
#. ./DK.sh
dk_includeGuard

##################################################################################
# dk_getFuncName()
#
#
dk_getFuncName() {
	dk_debugFunc
	[ -z "$1" ] && dk_error "get_func_name <variable> requires 1 parameter"
	
	eval "$1=${FUNCNAME[1]}"
	#echo "parameter name = $1"
	#echo "function name = ${FUNCNAME[1]}"
}