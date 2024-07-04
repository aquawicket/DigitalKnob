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
	#[ $# -ne 2 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	dk_validateArgs array element optional:rtn_var
	
	#typeset -n array="${1}"
	#dk_arrayLength array arrayPush			# parameter variable return
	if [ -n ${1-} ]; then
		local arrayPush=$(dk_arrayLength ${1})		# command substitution return
	fi
	eval "${1-}[${arrayPush}]=${2}"

	#eval "${3}=${arrayPush}"	# parameter variable return
	[ ${#} -gt 2 ] && eval "${3}=${arrayPush}" 
	dk_return ${arrayPush}; return		# command substitution return
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArrayA[0]=a				# FIXME - variable must exist for dk_arrayPush to work
	dk_printVar myArrayA
	
	dk_arrayPush myArrayA b
	dk_printArray myArrayA
	
	dk_arrayPush myArrayA c
	dk_printArray myArrayA
	
	dk_arrayPush myArrayA d
	dk_printArray myArrayA
	
	dk_arrayPush myArrayA f
	dk_printArray myArrayA
	
	
	
	
	
	myArrayB[0]=1				# FIXME - variable must exist for dk_arrayPush to work
	dk_printVar myArrayB
	
	dk_arrayPush myArrayB 2
	dk_printArray myArrayB
	
	dk_arrayPush myArrayB 3
	dk_printArray myArrayB
	
	dk_arrayPush myArrayB 4
	dk_printArray myArrayB
	
	dk_arrayPush myArrayB 5
	dk_printArray myArrayB
}