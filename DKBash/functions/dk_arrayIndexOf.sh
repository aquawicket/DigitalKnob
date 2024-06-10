#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

dk_fixme


################################################################################
# dk_arrayIndexOf(array, searchElement, index)
# dk_arrayIndexOf(array, searchElement, fromIndex, index)
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
#
dk_arrayIndexOf () {
	dk_debugFunc
	[ $# -ne 3 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	arry=$1
	_count_=0
	dk_set $3 "-1"
	for item in "${arry[@]}"; do
		[ $2 = "$item" ] && echo "$2 present in the array"
	done
}




DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	array[0]="a"
	array[1]="b"
	array[2]="c"
	array[3]="d"
	array[4]="e"
	
	dk_arrayIndexOf array "a" indexA
	dk_echo "indexA = %indexA%"
	
	dk_arrayIndexOf array "b" indexB
	dk_echo "indexB = %indexB%"
	
	dk_arrayIndexOf array "c" indexC
	dk_echo "indexC = %indexC%"
	
	dk_arrayIndexOf array "d" indexD
	dk_echo "indexD = %indexD%"
	
	dk_arrayIndexOf array "e" indexE
	dk_echo "indexE = %indexE%"
}