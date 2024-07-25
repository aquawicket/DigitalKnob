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
	
	eval local arrayA='("${'$1'[@]}")'		#typeset -n arrayA="${1}"
	eval local arrayB='("${'$2'[@]}")'		#typeset -n arrayB="${2}"
	new_array=("${arrayA[@]}" "${arrayB[@]}");
#	eval local new_array=(("${'$1'[@]}") ("${'$2'[@]}"));

	
	### return value ###
	[ ${#} -gt 2 ] && eval ${3}='("${new_array[@]}")' && return  	# return using parameter rtn_var
	
	dk_return new_array && return
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc
	
	myArray1[0]="a b c"
	myArray1[1]="d e f"
	myArray1[2]="g h i"
	
	myArray2[0]="1 2 3"
	myArray2[1]="4 5 6"
	myArray2[2]="7 8 9"
	
	dk_arrayConcat myArray1 myArray2 myNewArrayA
	dk_printVar myNewArrayA
	
	
	
	myArray3[0]="a b c"
	myArray3[1]="d e f"
	myArray3[2]="g h i"
	
	myArray4[0]="1 2 3"
	myArray4[1]="4 5 6"
	myArray4[2]="7 8 9"
	
	IFS=$'\n' myNewArrayB=($(dk_arrayConcat myArray3 myArray4))
	dk_printVar myNewArrayB
}
