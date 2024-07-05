#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayLength(array)
# dk_arrayLength(array rtn_var)
#
#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_length
#
dk_arrayLength (){
	dk_debugFunc
	#[ ${#} -lt 1 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	#[ ${#} -gt 2 ] && dk_error "${FUNCNAME}(${#}): too many arguments"
	dk_validateArgs array optional:rtn_var
	
	typeset -n _array_=${1}
	local array_length=${#_array_[@]}
	
	#dk_assert array_length
	#dk_printVar array_length
	
	[ ${#} -gt 1 ] && eval "${2}=${array_length}"
	dk_return ${array_length}; return
}




DKTEST (){ ########################################################################
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
