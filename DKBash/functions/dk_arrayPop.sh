#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayPop(array)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_pop
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop
#
dk_arrayPop (){
	dk_debugFunc
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	#dk_validateArgs array
	
	#dk_arrayLength ${1} _length_
	local _length_=$(dk_arrayLength ${1})
	_length_=$((_length_ - 1))
	dk_unset ${1}[$_length_]
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArray[0]="a"
	myArray[1]="b"
	myArray[2]="c"
	myArray[3]="d"
	myArray[4]="e"
	
	dk_printVar myArray
	
	dk_arrayPop myArray
	dk_printVar myArray
	
	dk_arrayPop myArray
	dk_printVar myArray
	
	dk_arrayPop myArray
	dk_printVar myArray
	
	dk_arrayPop myArray
	dk_printVar myArray
	
	dk_arrayPop myArray
	dk_printVar myArray
	
	# FIXME:  out of array bounds past here
#	dk_arrayPop myArray
#	dk_printVar myArray
	
#	dk_arrayPop myArray
#	dk_printVar myArray
	
#	dk_arrayPop myArray
#	dk_printVar myArray	
}
