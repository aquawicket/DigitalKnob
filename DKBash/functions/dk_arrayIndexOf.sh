#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


################################################################################
# dk_arrayIndexOf(array, searchElement, rtn_val)
# dk_arrayIndexOf(array, searchElement, fromIndex, rtn_val)
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
#
dk_arrayIndexOf (){
	dk_debugFunc
	[ $# -ne 3 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	typeset -n arry=$1 
	for ((i=0; i < ${#arry[@]}; i++ )); do
		if [ "${2}" = "${arry[$i]}" ]; then
			eval "${3}=${i}" 
			return ${true}
		fi
	done
	eval "${3}=-1" 
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArray[0]="a"
	myArray[1]="b"
	myArray[2]="c"
	myArray[3]="d"
	myArray[4]="e"
	
	dk_arrayIndexOf myArray "a" indexA
	dk_echo "indexA = ${indexA}"
	
	dk_arrayIndexOf myArray "b" indexB
	dk_echo "indexB = ${indexB}"
	
	dk_arrayIndexOf myArray "c" indexC
	dk_echo "indexC = ${indexC}"
	
	dk_arrayIndexOf myArray "d" indexD
	dk_echo "indexD = ${indexD}"
	
	dk_arrayIndexOf myArray "e" indexE
	dk_echo "indexE = ${indexE}"
	
	dk_arrayIndexOf myArray "nonExistant" indexN
	dk_echo "indexN = ${indexN}"
}