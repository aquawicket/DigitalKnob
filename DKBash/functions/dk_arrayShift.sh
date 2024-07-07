#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayShift(array)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_shift
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift
#
dk_arrayShift (){
	dk_debugFunc
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	typeset -n arrayShift=${1} 
	prev=0
	count=1
	
	arrayShift=("${arrayShift[@]:1}")

	[ ${#} -gt 1 ] && eval "${2}=${arrayShift}" 
	dk_return ${arrayShift}; return		# command substitution return
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	myArray[0]="a"
	myArray[1]="b"
	myArray[2]="c"
	myArray[3]="d"
	myArray[4]="e"
	
	dk_printVar myArray
	
	dk_arrayShift myArray
	dk_printVar myArray
	
	dk_arrayShift myArray
	dk_printVar myArray
	
	dk_arrayShift myArray
	dk_printVar myArray
	
	dk_arrayShift myArray
	dk_printVar myArray
	
	dk_arrayShift myArray
	dk_printVar myArray
	
	dk_arrayShift myArray
	dk_printVar myArray
}
