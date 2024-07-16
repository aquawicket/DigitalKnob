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
dk_arrayConcat() {
	dk_debugFunc
	[ ${#} -lt 2 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	[ ${#} -gt 3 ] && dk_error "${FUNCNAME}(${#}): too many arguments"
	#dk_validateArgs array array
	
	eval arrayA=('${'$1'[@]}')	 #typeset -n arrayA="${1}"
	eval arrayB=('${'$2'[@]}')	 #typeset -n arrayB="${2}"
	new_array=(${arrayA[@]} ${arrayB[@]});
	dk_printVar new_array
	[ ${#} -gt 2 ] && eval ${3}='(${new_array[@]})' # return using parameter rtn_var
	dk_return "${new_array[@]}"; return				# return through command substitution    # FIXME
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArray1[0]="a"
	myArray1[1]="b"
	myArray1[2]="c"
	
	myArray2[0]="1"
	myArray2[1]="2"
	myArray2[2]="3"
	
	myNewArrayA="($(dk_arrayConcat myArray1 myArray2))"
	dk_printVar myNewArrayA
	
	
	myArray3[0]="x"
	myArray3[1]="y"
	myArray3[2]="z"
	
	myArray4[0]="7"
	myArray4[1]="8"
	myArray4[2]="9"
	
	dk_arrayConcat myArray3 myArray4 myNewArrayB
	dk_printVar myNewArrayB
}
