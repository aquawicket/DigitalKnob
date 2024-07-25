#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayPop(array)
# dk_arrayPop(array, rtn_var)
#
#	Return value
#   The removed element from the array; undefined if the array is empty.
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_pop
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop
#
dk_arrayPop() {
	dk_debugFunc
	[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	[ ${#} -gt 2 ] && dk_error "${FUNCNAME}(${#}): too many arguments"
	#dk_validateArgs array
	
	eval local array='("${'$1'[@]}")'			#typeset -n array=${1}
	local _length_=${#array[@]}
	_length_=$((_length_ - 1))
	eval local removedElement='("${'array'[$_length_]}")'
	dk_unset array[$_length_]
	
	### return value ###
	eval ${1}='("${array[@]}")'  # FIXME: command substitution cannot alter parent variables
	[ ${#} -gt 1 ] && eval ${2}='"${removedElement}"' && return	# return value using return variable
	dk_return "${removedElement}" && return						# return value using command substitution
}




DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc
	
	myArrayA[0]="a b c"
	myArrayA[1]="1 2 3"
	myArrayA[2]="d e f"
	myArrayA[3]="4 5 6"
	myArrayA[4]="h i j"
	
	dk_printVar myArrayA 
	dk_echo
	
	dk_arrayPop myArrayA removedA
	dk_printVar myArrayA
	dk_printVar removedA
	dk_echo
	
	dk_arrayPop myArrayA removedA
	dk_printVar myArrayA
	dk_printVar removedA
	dk_echo
	
	dk_arrayPop myArrayA removedA
	dk_printVar myArrayA
	dk_printVar removedA
	dk_echo
	
	dk_arrayPop myArrayA removedA
	dk_printVar myArrayA
	dk_printVar removedA
	dk_echo
	
	dk_arrayPop myArrayA removedA
	dk_printVar myArrayA
	dk_printVar removedA
	dk_echo
	
	# FIXME:  out of array bounds past here
#	dk_arrayPop myArrayA removedA
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
	
	removedB=$(dk_arrayPop myArrayB)
	dk_printVar myArrayB
	dk_printVar removedB
	dk_echo
	
	removedB=$(dk_arrayPop myArrayB)
	dk_printVar myArrayB
	dk_printVar removedB
	dk_echo
	
	removedB=$(dk_arrayPop myArrayB)
	dk_printVar myArrayB
	dk_printVar removedB
	dk_echo
	
	removedB=$(dk_arrayPop myArrayB)
	dk_printVar myArrayB
	dk_printVar removedB
	dk_echo
	
	removedB=$(dk_arrayPop myArrayB)
	dk_printVar myArrayB
	dk_printVar removedB
	dk_echo
	
	# FIXME:  out of array bounds past here
	removedB=$(dk_arrayPop myArrayB)
	dk_printVar myArrayB
	dk_printVar removedB
	dk_echo
}
