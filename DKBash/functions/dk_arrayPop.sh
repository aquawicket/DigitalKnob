#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

################################################################################
# dk_arrayPop(array)
# dk_arrayPop(array, rtn_var)
#
#    The pop() method of Array instances removes the last element from an array and returns that element. This method changes the length of the array.
#
#    PARAMETERS
#    array
#
#	 RETURN VALUE
#    The removed element from the array; undefined if the array is empty.
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/pop
#
dk_arrayPop() {
	dk_debugFunc 1 2
	#dk_validateArgs array
	
	eval local array='("${'$1'[@]}")'		#typeset -n array=${1}	
	[ -n "${2-}" ] && local rtn_var="${2}" || local rtn_var="dk_arrayPop"
	
	
	local _length_=${#array[@]}
	_length_=$((_length_ - 1))
	eval local _arrayPop='("${'array'[$_length_]}")'
	dk_call dk_unset array[$_length_]
	
	### return value ###
	eval ${1}='("${array[@]}")'				# update the parent array
	eval ${rtn_var}='("${_arrayPop[@]}")'	# return value in FUNCTION_NAME or RETURN_VAR
	dk_return "${_arrayPop[*]}"				# return value using command substitution
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	dk_call dk_echo
	myArray[0]="a b c"
	myArray[1]="1 2 3"
	myArray[2]="d e f"
	myArray[3]="4 5 6"
	myArray[4]="h i j"
	dk_call dk_printVar myArray
	
	# return value in FUNCTION_NAME
	dk_call dk_echo
	dk_call dk_arrayPop myArray
	dk_call dk_printVar myArray
	dk_call dk_printVar dk_arrayPop
	[ "${myArray[0]-}" = "a b c" ] && \
	[ "${myArray[1]-}" = "1 2 3" ] && \
	[ "${myArray[2]-}" = "d e f" ] && \
	[ "${myArray[3]-}" = "4 5 6" ] && \
	[ ! "${myArray[4]-}" = "h i j" ] && \
	[ "${dk_arrayPop-}" = "h i j" ] && \
	dk_call dk_success "dk_arrayPop succeeded" || \
	dk_call dk_error "dk_arrayPop failed"
	
	# return value in FUNCTION_NAME
	dk_call dk_echo
	dk_call dk_arrayPop myArray rv_arrayPop
	dk_call dk_printVar myArray
	dk_call dk_printVar rv_arrayPop
	
	# FIXME: command substitution cannot alter parent variables
	# return value in COMMAND_SUBSTITUTION
	# dk_call dk_echo
	# cs_arrayPop=$(dk_arrayPop myArray)
	# dk_printVar myArray
	# dk_printVar cs_arrayPop
}
