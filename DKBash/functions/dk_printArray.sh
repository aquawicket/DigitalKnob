#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_printArray(array)
#
#
dk_printArray (){
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	typeset -n arry=$1 
	for ((i=0; i < ${#arry[@]}; i++ )); do
		dk_info "${1}[$i] = ${arry[$i]}"
	done
	dk_info "$1 length = $i"
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArray[0]="a"
	myArray[1]="b"
	myArray[2]="c"
	myArray[3]="d"
	myArray[4]="e"
	
	dk_printArray myArray
}