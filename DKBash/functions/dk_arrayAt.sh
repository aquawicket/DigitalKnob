#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

################################################################################
# dk_arrayAt(array, index)
# dk_arrayAt(array, index, rtn_var)
#
#	 Takes an array instance with an integer value and returns the item at that index, 
#	 allowing for positive and negative integers. Negative integers count back from the last item in the array.  <-- TODO
#
#    PARAMETERS
#    index
#    Zero-based index of the array element to be returned, converted to an integer. Negative index counts back from the end of the array — if index < 0, index + array.length is accessed.
#
#    RETURN VALUE
#    The element in the array matching the given index. Always returns undefined if index < -array.length or index >= array.length without attempting to access the corresponding property.
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
dk_arrayAt() {
	dk_debugFunc 2 3
	#dk_call dk_validateArgs array int optional:rtn_var
	
	eval local _arrayAt='${'${1}'[${2}]}'
	[ -n "${3-}" ] && local rtn_var="${3}" || local rtn_var="dk_arrayAt"
	
	### return value ###
	eval "${rtn_var}=\"${_arrayAt}\"" 	# return value in FUNCTION_NAME or RETURN_VAR
	dk_return "${_arrayAt}"				# return value in COMMAND_SUBSTITUTION
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myArray[0]="a b c"
	myArray[1]="1 2 3"
	myArray[2]="d e f"
	myArray[3]="4 5 6"
	myArray[4]="h i j"
	myArray[5]="7 8 9"
	dk_call dk_printVar myArray
	
	# return value in FUNCTION_NAME
	dk_call dk_arrayAt myArray 1
	dk_call dk_printVar dk_arrayAt
	[ "${dk_arrayAt}" = "1 2 3" ] && dk_call dk_success "dk_arrayAt() suceeded" || dk_call dk_error "dk_arrayAt() failed"
	
	# return value in RETURN_VAR
	dk_call dk_arrayAt myArray 2 rv_arrayAt
	dk_call dk_printVar rv_arrayAt
	[ "${rv_arrayAt}" = "d e f" ] && dk_call dk_success "dk_arrayAt() suceeded" || dk_call dk_error "dk_arrayAt() failed"
	
	# return value in COMMAND_SUBSTITUTION
	cs_arrayAt=$(dk_call dk_arrayAt myArray 3)
	dk_call dk_printVar cs_arrayAt
	[ "${cs_arrayAt}" = "4 5 6" ] && dk_call dk_success "dk_arrayAt() suceeded" || dk_call dk_error "dk_arrayAt() failed"
}
