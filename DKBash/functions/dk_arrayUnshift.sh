#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayUnshift(array, element)
# dk_arrayUnshift(array, element, rtn_var)
#
#    Adds the specified elements to the beginning of an array and returns the new length of the array.
#
#    PARAMETERS
#    element1, …, elementN
#    The elements to add to the front of the arr.
#
#    RETURN VALUE
#    The new length property of the object upon which the method was called.
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_unshift
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/unshift
#
dk_arrayUnshift() {
	dk_debugFunc 2 99
	#dk_validateArgs array element optional:rtn_var
	
	eval local array='("${'$1'[@]}")'			#typeset -n array=${1}
	array=("${@:2}" "${array[@]}");
	local _length_=${#array[@]}
	
	### return value ###
	eval ${1}='("${array[@]}")'	# FIXME: command substitution cannot alter parent variables
	[ ${#} -gt 2 ] && eval ${3}=${_length_} && return	# return value using return variable
	dk_call dk_return ${_length_} && return					# return value using command substitution
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_arrayUnshift myArrayA "a b c" #new_lengthA
	dk_call dk_printVar myArrayA
	#dk_call dk_printVar new_lengthA
	
	dk_call dk_arrayUnshift myArrayA "1 2 3" #new_lengthA
	dk_call dk_printVar myArrayA
	#dk_call dk_printVar new_lengthA
	
	dk_call dk_arrayUnshift myArrayA "d e f" #new_lengthA
	dk_call dk_printVar myArrayA
	#dk_call dk_printVar new_lengthA
	
	dk_call dk_arrayUnshift myArrayA "4 5 6" #new_lengthA
	dk_call dk_printVar myArrayA
	#dk_call dk_printVar new_lengthA
	
	dk_call dk_arrayUnshift myArrayA "h i j" #new_lengthA
	dk_call dk_printVar myArrayA
	#dk_call dk_printVar new_lengthA
	
	
	# FIXME: command substitution cannot alter parent variables
	new_lengthB=$(dk_call dk_arrayUnshift myArrayB "h i j")
	dk_call dk_printVar myArrayB
	dk_call dk_printVar new_lengthB
	
	new_lengthB=$(dk_call dk_arrayUnshift myArrayB "4 5 6")
	dk_call dk_printVar myArrayB
	dk_call dk_printVar new_lengthB
	
	new_lengthB=$(dk_call dk_arrayUnshift myArrayB "d e f")
	dk_call dk_printVar myArrayB
	dk_call dk_printVar new_lengthB
	
	new_lengthB=$(dk_call dk_arrayUnshift myArrayB "1 2 3")
	dk_call dk_printVar myArrayB
	dk_call dk_printVar new_lengthB
	
	new_lengthB=$(dk_call dk_arrayUnshift myArrayB "a b c")
	dk_call dk_printVar myArrayB
	dk_call dk_printVar new_lengthB
}
