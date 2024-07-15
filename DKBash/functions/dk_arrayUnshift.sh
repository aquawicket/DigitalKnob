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
	
	eval local array=('${'$1'[@]}')			#typeset -n array=${1}
	array=("${@:2}" "${array[@]}");
	#dk_printVar array

	eval ${1}="(${array[@]})"
	#dk_return ${array}; return		# command substitution return
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_arrayUnshift myArray a
	dk_printVar myArray
	
	dk_arrayUnshift myArray b
	dk_printVar myArray
	
	dk_arrayUnshift myArray c
	dk_printVar myArray
	
	dk_arrayUnshift myArray d
	dk_printVar myArray


	dk_arrayUnshift myArrayB 1
	dk_arrayUnshift myArrayB 2
	dk_arrayUnshift myArrayB 3
	dk_arrayUnshift myArrayB 4
	dk_printVar myArrayB
}
