#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

dk_fixme
################################################################################
# dk_arrayPush(array, element1, element2, /* …, */ elementN)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
#
dk_arrayPush () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	echo "1 = ${1-}"
	echo "2 = ${2-}"
	
	typeset -n array=$1
	
	dk_arrayLength array end_index
	dk_set $array[${end_index}] "$2"
}




DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	myArray[0]="a"
	myArray[1]="b"
	myArray[2]="c"
	dk_printArray myArray
	
	dk_arrayPush myArray a
	dk_printArray myArray
	
	dk_arrayPush myArray b
	dk_printArray myArray
	
	dk_arrayPush myArray c
	dk_printArray myArray
	
	dk_arrayPush myArray d
	dk_printArray myArray
}