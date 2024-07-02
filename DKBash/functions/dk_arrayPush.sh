#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_arrayPush(array, element1, element2, /* …, */ elementN)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
#
dk_arrayPush (){
	dk_debugFunc
	#[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	dk_validateArgs array element
	
	typeset -n array=${1}
	local end_index=$(dk_arrayLength array)		# command substitution return
	#dk_arrayLength array end_index				# parameter variable return

	eval ${array}[${end_index}]="${2}"
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArray[0]="a"
	myArray[1]="b"
	myArray[2]="c"
	dk_printArray myArray
	
	dk_arrayPush myArray d
	dk_printArray myArray
	
	dk_arrayPush myArray e
	dk_printArray myArray
	
	dk_arrayPush myArray f
	dk_printArray myArray
	
	dk_arrayPush myArray g
	dk_printArray myArray
}