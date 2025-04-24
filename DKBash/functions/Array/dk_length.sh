#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

################################################################################
# dk_arrayLength(array)
# dk_arrayLength(array rtn_var)
#
#    The length data property of an Array instance represents the number of elements in that array. 
#    The value is an unsigned, 32-bit integer that is always numerically greater than the highest index in the array.
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/length
#
dk_arrayLength() {
	dk_debugFunc 1 2
	#dk_call dk_validateArgs array optional:rtn_var
	
	eval local array=('${'$1'[@]}')			#typeset -n array=${1}
	local arrayLength=${#array[@]}
	
	[ ${#} -gt 1 ] && eval ${2}=${arrayLength} && return
	dk_return ${arrayLength} && return
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myArrayA[0]="a b c"
	myArrayA[1]="1 2 3"
	myArrayA[2]="d e f"
	myArrayA[3]="4 5 6"
	myArrayA[4]="h i j"
	dk_call dk_arrayLength myArrayA myArrayLengthA
	dk_call dk_printVar myArrayLengthA
	
	
	myArrayB[0]="h i j"
	myArrayB[1]="4 5 6"
	myArrayB[2]="d e f"
	myArrayB[3]="1 2 3"
	myArrayB[4]="a b c"
	myArrayLengthB=$(dk_call dk_arrayLength myArrayB)
	dk_call dk_printVar myArrayLengthB
}
