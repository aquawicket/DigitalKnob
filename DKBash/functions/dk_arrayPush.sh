#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_arrayPush(array, element1, element2, /* …, */ elementN)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
#
#    element1, …, elementN
#        The element(s) to add to the end of the array.
#
#   Return value
#    The new length property of the object upon which the method was called.
#
dk_arrayPush (){
	dk_debugFunc
	#[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	dk_validateArgs array element
	
	#typeset -n array="${1}"
	#dk_arrayLength array end_index			# parameter variable return
	if [ -n ${1} ]; then
		local end_index=$(dk_arrayLength ${1})		# command substitution return
	fi
	eval "${1}[${end_index}]=${2}"

	#eval "${3}=${end_index}"	# parameter variable return
	dk_return ${end_index}		# command substitution return
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
#	myArray[0]="a"
#	myArray[1]="b"
#	myArray[2]="c"
	dk_printVar myArray
	
	dk_arrayPush myArray d
	dk_printArray myArray
	
	dk_arrayPush myArray e
	dk_printArray myArray
	
	dk_arrayPush myArray f
	dk_printArray myArray
	
	dk_arrayPush myArray g
	dk_printArray myArray
}