#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayConcat(array, {value1, value2, /* …, */ valueN})
# dk_arrayConcat(array, {value1, value2, /* …, */ valueN}, rtn_var)
#
#	The dk_arrayConcat() method is used to merge two or more arrays. This method does not change the existing arrays, but instead returns a new array.
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
#
dk_arrayConcat (){
	dk_debugFunc
	#[ ${#} -ne 2 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	dk_validateArgs array array
	
	typeset -n arrayA="${1}"
	typeset -n arrayB="${2}"
	new_array=("${arrayA[@]}" "${arrayB[@]}");
	dk_printVar new_array
	
	[ ${#} -gt 2 ] && eval "${3}=${new_array}" 		# return using parameter rtn_var
	dk_return ${new_array}; return					# return through command substitution 
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArray1[0]="a"
	myArray1[1]="b"
	myArray1[2]="c"
	
	myArray2[0]="1"
	myArray2[1]="2"
	myArray2[2]="3"
	
	myArray3=($(dk_arrayConcat myArray1 myArray2))
	dk_printVar myArray3
}
