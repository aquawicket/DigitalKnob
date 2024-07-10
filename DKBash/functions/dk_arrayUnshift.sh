#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayUnshift(array, element)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_unshift
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/unshift
#
dk_arrayUnshift (){
	dk_debugFunc
	[ ${#} -lt 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	#dk_validateArgs array element optional:rtn_var
	
	typeset -n array=${1}
	array=(${@:2} ${array[@]});
	eval ${1}=${array}

	#[ ${#} -gt 2 ] && eval "${3}=${array}" 
	#dk_return ${array}; return		# command substitution return
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArray[0]=a
	myArray[1]=b
	myArray[2]=c
	myArray[3]=d
	myArray[4]=e
	
	dk_printVar myArray
	
	dk_arrayUnshift myArray 1
	dk_printVar myArray
	
	dk_arrayUnshift myArray 2
	dk_printVar myArray
	
	dk_arrayUnshift myArray 3
	dk_printVar myArray
	
	dk_arrayUnshift myArray 4
	dk_printVar myArray
	
	dk_arrayUnshift myArray 5
	dk_printVar myArray
	
	dk_arrayUnshift myArray 6
	dk_printVar myArray
}
