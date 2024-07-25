#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayLength(array)
# dk_arrayLength(array rtn_var)
#
#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_length
#
dk_arrayLength() {
	dk_debugFunc
	[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	[ ${#} -gt 2 ] && dk_error "${FUNCNAME}(${#}): too many arguments"
	#dk_validateArgs array optional:rtn_var
	
	eval local array=('${'$1'[@]}')			#typeset -n array=${1}
	local arrayLength=${#array[@]}
	
	[ ${#} -gt 1 ] && eval ${2}=${arrayLength} && return
	dk_return ${arrayLength} && return
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc
	
	myArrayA[0]="a b c"
	myArrayA[1]="1 2 3"
	myArrayA[2]="d e f"
	myArrayA[3]="4 5 6"
	myArrayA[4]="h i j"
	dk_arrayLength myArrayA myArrayLengthA
	dk_printVar myArrayLengthA
	
	
	myArrayB[0]="h i j"
	myArrayB[1]="4 5 6"
	myArrayB[2]="d e f"
	myArrayB[3]="1 2 3"
	myArrayB[4]="a b c"
	myArrayLengthB=$(dk_arrayLength myArrayB)
	dk_printVar myArrayLengthB
}
