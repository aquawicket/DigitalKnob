#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


################################################################################
# dk_arrayLength(array)
# dk_arrayLength(array, rtn_var)
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
	
	eval local array='("${'$1'[@]}")'		#typeset -n array=${1}	
	[ -n "${2-}" ] && local rtn_var="${2}" || local rtn_var="dk_arrayLength"
	
	local _arrayLength=${#array[@]}
	
	eval "${rtn_var}=\"${_arrayLength}\"" 	# return value in FUNCTION_NAME or RETURN_VAR
	dk_return "${_arrayLength}"				# return value in COMMAND_SUBSTITUTION
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myArray[0]="a b c"
	myArray[1]="1 2 3"
	myArray[2]="d e f"
	myArray[3]="4 5 6"
	myArray[4]="h i j"
	dk_call dk_printVar myArray
	
	# return value in FUNCTION_NAME
	dk_call dk_arrayLength myArray
	dk_call dk_printVar dk_arrayLength
	[ "${dk_arrayLength}" = "5" ] && dk_call dk_success "dk_arrayLength() suceeded" || dk_call dk_error "dk_arrayLength() failed"
	
	# return value in RETURN_VAR
	dk_call dk_arrayLength myArray rv_arrayLength
	dk_call dk_printVar rv_arrayLength
	[ "${rv_arrayLength}" = "5" ] && dk_call dk_success "dk_arrayLength() suceeded" || dk_call dk_error "dk_arrayLength() failed"
	
	# return value in COMMAND_SUBSTITUTION
	cs_arrayLength=$(dk_call dk_arrayLength myArray)
	dk_call dk_printVar cs_arrayLength
	[ "${cs_arrayLength}" = "5" ] && dk_call dk_success "dk_arrayLength() suceeded" || dk_call dk_error "dk_arrayLength() failed"
}
