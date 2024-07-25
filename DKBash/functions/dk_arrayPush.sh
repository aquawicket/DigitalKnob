#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

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
dk_arrayPush() {
	dk_debugFunc
	[ ${#} -lt 2 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	#dk_validateArgs array element optional:rtn_var
	
	eval local array='("${'$1'[@]}")'			#typeset -n array=${1}
	array=("${array[@]}" "${@:2}");
	
	# FIXME: the new array does not get assigned in command substitution.
	# i.e.  new_length=${dk_arrayPush myArray "new item"} 

	### return value ###
	eval ${1}='("${array[@]}")'

	#[ ${#} -gt 2 ] && eval ${3}=${#array[@]} && return	# variable parameter return
	
	# FIXME: the new array does not get assigned in command substitution.
	dk_return ${#array[@]} && return					# command substitution return
}




DKTEST() { ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc
	
	dk_arrayPush myArrayA "a b c"
	dk_printVar myArrayA
	
	dk_arrayPush myArrayA "1 2 3" "4 5 6"
	dk_printVar myArrayA
	
	# FIXME: the new array does not get assigned in command substitution.
	new_length=$(dk_arrayPush 'myArrayA' "d e f")
	dk_printVar myArrayA
	dk_printVar new_length
	
	# FIXME: the new array does not get assigned in command substitution.
	new_length=$(dk_arrayPush myArrayA "7 8 9" "10 11 12")
	dk_printVar myArrayA
	dk_printVar new_length
}