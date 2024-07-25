#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayShift(array)
# dk_arrayShift(array, rtn_var)
#
#	 Removes the first element from an array and returns that removed element. 
#    This method changes the length of the array.
#
#    Return value
#    The removed element from the array; undefined if the array is empty.
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_shift
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/shift
#
dk_arrayShift() {
	dk_debugFunc
	[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	[ ${#} -gt 2 ] && dk_error "${FUNCNAME}(${#}): too many arguments"
	#dk_validateArgs array
	
	eval local array='("${'$1'[@]}")'			#typeset -n array=${1}
	eval local removedElement='("${'array'[0]}")'
	array=("${array[@]:1}")
	
	### return value ###
	eval ${1}='("${array[@]}")'
	[ ${#} -gt 1 ] && eval ${2}='"${removedElement}"' && return	# return value using return variable
	
	# FIXME: command substitution cannot alter parent variables
	dk_return "${removedElement}" && return						# return value using command substitution

}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc
	
	myArrayA[0]="a b c"
	myArrayA[1]="1 2 3"
	myArrayA[2]="d e f"
	myArrayA[3]="4 5 6"
	myArrayA[4]="h i j"
	
	dk_printVar myArrayA
	dk_echo
	
	dk_arrayShift myArrayA removedA
	dk_printVar myArrayA
	dk_printVar removedA
	dk_echo
	
	dk_arrayShift myArrayA removedA
	dk_printVar myArrayA
	dk_printVar removedA
	dk_echo
	
	dk_arrayShift myArrayA removedA
	dk_printVar myArrayA
	dk_printVar removedA
	dk_echo
	
	dk_arrayShift myArrayA removedA
	dk_printVar myArrayA
	dk_printVar removedA
	dk_echo
	
	dk_arrayShift myArrayA removedA
	dk_printVar myArrayA
	dk_printVar removedA
	dk_echo
	
	# FIXME:  out of array bounds past here
#	dk_arrayShift myArrayA removedA
#	dk_printVar myArrayA
#	dk_printVar removedA
	dk_echo
	dk_echo
	
	
	
	# FIXME: command substitution cannot alter parent variables
	myArrayB[0]="h i j"
	myArrayB[1]="4 5 6"
	myArrayB[2]="d e f"
	myArrayB[3]="1 2 3"
	myArrayB[4]="a b c"
	
	dk_printVar myArrayB 
	dk_echo
	
	removedB=$(dk_arrayShift myArrayB)
	dk_printVar myArrayB
	dk_printVar removedB
	dk_echo
	
	removedB=$(dk_arrayShift myArrayB)
	dk_printVar myArrayB
	dk_printVar removedB
	dk_echo
	
	removedB=$(dk_arrayShift myArrayB)
	dk_printVar myArrayB
	dk_printVar removedB
	dk_echo
	
	removedB=$(dk_arrayShift myArrayB)
	dk_printVar myArrayB
	dk_printVar removedB
	dk_echo
	
	removedB=$(dk_arrayShift myArrayB)
	dk_printVar myArrayB
	dk_printVar removedB
	dk_echo
	
	# FIXME:  out of array bounds past here
	removedB=$(dk_arrayShift myArrayB)
	dk_printVar myArrayB
	dk_printVar removedB
	dk_echo
}
