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
	
	#dk_assert arrayLength
	#dk_printVar arrayLength
	
	[ ${#} -gt 1 ] && eval "${2}=${arrayLength}"
	dk_return ${arrayLength}; return
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc
	
	myArrayA=("element A" "element B" "element C")
	myArrayLengthA=$(dk_arrayLength myArrayA)
	#dk_arrayLength myArrayA myArrayLengthA
	dk_printVar myArrayLengthA
	
	
	
	myArrayB=("element 1" "element 2" "element 3")
	#myArrayLengthB=$(dk_arrayLength myArrayB)
	dk_arrayLength myArrayB myArrayLengthB
	dk_printVar myArrayLengthB
}
