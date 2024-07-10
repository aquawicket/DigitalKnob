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
dk_arrayPush (){
	dk_debugFunc
	[ ${#} -lt 2 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	#dk_validateArgs array element optional:rtn_var
	
	typeset -n array=${1}
	array=("${array[@]}" "${@:2}");
	#dk_printVar array

	#[ ${#} -gt 2 ] && eval "${3}=${arrayPush}" # parameter variable return
	#dk_return ${arrayPush}; return		# command substitution return
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_arrayPush myArrayA a
	dk_printVar myArrayA
	
	dk_arrayPush myArrayA b
	dk_printVar myArrayA
	
	dk_arrayPush myArrayA c
	dk_printVar myArrayA
	
	dk_arrayPush myArrayA d
	dk_printVar myArrayA
	
	
	dk_arrayPush myArrayB 1
	dk_arrayPush myArrayB 2
	dk_arrayPush myArrayB 3
	dk_arrayPush myArrayB 4
	dk_printVar myArrayB
	
	
	dk_arrayPush CMAKE_ARGS cmake
	dk_arrayPush CMAKE_ARGS -G "MSYS Makefiles"
	dk_arrayPush CMAKE_ARGS -DDEBUG=ON
	dk_arrayPush CMAKE_ARGS -DREBUILDALL=ON
	dk_echo "CMAKE_ARGS = ${CMAKE_ARGS[*]}"
	dk_printVar CMAKE_ARGS
}