#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

dk_fixme
################################################################################
# dk_arrayShift(array)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_shift
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift
#
dk_arrayShift () {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	_arry_="$1"
	prev=0
	count=1
	
#	:dk_arrayShift_loop
#	if defined $_arry_[$count] (
#		"$_arry_[$prev]=$_arry_[$count]"
#		count+=1
#		prev+=1
#		goto:dk_arrayShift_loop
#	)
#	dk_unset $_arry_[$prev]
}




DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	myArray[0]="a"
	myArray[1]="b"
	myArray[2]="c"
	myArray[3]="d"
	myArray[4]="e"
	
	dk_printArray myArray
	
	dk_arrayShift myArray
	dk_printArray myArray
	
	dk_arrayShift myArray
	dk_printArray myArray
	
	dk_arrayShift myArray
	dk_printArray myArray
	
	dk_arrayShift myArray
	dk_printArray myArray
	
	dk_arrayShift myArray
	dk_printArray myArray
	
	dk_arrayShift myArray
	dk_printArray myArray
}
