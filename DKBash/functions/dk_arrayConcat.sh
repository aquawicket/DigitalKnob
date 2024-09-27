#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

################################################################################
# dk_arrayConcat(array, {value1, value2, /* …, */ valueN})
# dk_arrayConcat(array, {value1, value2, /* …, */ valueN}, rtn_var)
#
#	 Merge two or more arrays. This method does not change the existing arrays, but instead returns a new array.
#
#    PARAMETERS
#    value1, …, valueN Optional
#        Arrays and/or values to concatenate into a new array. 
#        If all valueN parameters are omitted, concat returns a shallow copy of the existing array on which it is called. See the description below for more details.
#
#    RETURN VALUE
#    A new Array instance.
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat
#
dk_arrayConcat() {
	dk_debugFunc 2 3
	#dk_call dk_validateArgs array array
	
	eval local arrayA='("${'$1'[@]}")'		#typeset -n arrayA="${1}"
	eval local arrayB='("${'$2'[@]}")'		#typeset -n arrayB="${2}"
	new_array=("${arrayA[@]}" "${arrayB[@]}");
	# eval local new_array=(("${'$1'[@]}") ("${'$2'[@]}"));

	### return value ###
	[ ${#} -gt 2 ] && eval ${3}='("${new_array[@]}")' && return  	# return using parameter rtn_var
	dk_return "${new_array[@]}" && return							# FIXME
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myArray1[0]="a b c"
	myArray1[1]="d e f"
	myArray1[2]="g h i"
	
	myArray2[0]="1 2 3"
	myArray2[1]="4 5 6"
	myArray2[2]="7 8 9"
	
	dk_call dk_arrayConcat myArray1 myArray2 myNewArrayA
	dk_call dk_printVar myNewArrayA
	
	[ "${myNewArrayA[0]-}" = "a b c" ] && \
	[ "${myNewArrayA[1]-}" = "d e f" ] && \
	[ "${myNewArrayA[2]-}" = "g h i" ] && \
	[ "${myNewArrayA[3]-}" = "1 2 3" ] && \
	[ "${myNewArrayA[4]-}" = "4 5 6" ] && \
	[ "${myNewArrayA[5]-}" = "7 8 9" ] && \
	dk_call dk_echo "dk_arrayConcat succeeded" || \
	dk_call dk_echo "dk_arrayConcat failed"
	
	myArray3[0]="a b c"
	myArray3[1]="d e f"
	myArray3[2]="g h i"
	
	myArray4[0]="1 2 3"
	myArray4[1]="4 5 6"
	myArray4[2]="7 8 9"
	
	IFS=$'\n' myNewArrayB=($(dk_call dk_arrayConcat myArray3 myArray4))
	dk_call dk_printVar myNewArrayB
	
	[ "${myNewArrayB[0]-}" = "a b c" ] && \
	[ "${myNewArrayB[1]-}" = "d e f" ] && \
	[ "${myNewArrayB[2]-}" = "g h i" ] && \
	[ "${myNewArrayB[3]-}" = "1 2 3" ] && \
	[ "${myNewArrayB[4]-}" = "4 5 6" ] && \
	[ "${myNewArrayB[5]-}" = "7 8 9" ] && \
	dk_call dk_echo "dk_arrayConcat succeeded" || \
	dk_call dk_echo "dk_arrayConcat failed"
}
