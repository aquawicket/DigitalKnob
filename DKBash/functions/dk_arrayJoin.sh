#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

################################################################################
# dk_arrayJoin(array)
# dk_arrayJoin(array, separator)
# dk_arrayJoin(array, separator, rtn_var)
#
#    The join() method of Array instances creates and returns a new string by concatenating all of the elements in this array, separated by commas or a specified separator string. 
#    If the array has only one item, then that item will be returned without using the separator.
#
#    PARAMETERS
#    separator :optional
#        A string to separate each pair of adjacent elements of the array. If omitted, the array elements are separated with a comma (",").
#
#    RETURN VALUE
#    A string with all array elements joined. If array.length is 0, the empty string is returned.
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
#
dk_arrayJoin() {
	dk_debugFunc 1 3
	#dk_call dk_validateArgs array string optional:rtn_var

	eval local _array_='("${'$1'[@]}")'			#typeset -n _array_=${1}
	[ -n "${2-}" ] && local separator="${2}" || local separator=","
	[ -n "${3-}" ] && local rtn_var="${3}" || local rtn_var="dk_arrayJoin"
	
	for ((i=0; i < ${#_array_[@]}; i++ )); do
		if [ -z "${_arrayJoin-}" ]; then
			local _arrayJoin="${_array_[${i}]}"
		else
		    local _arrayJoin="${_arrayJoin}${separator}${_array_[${i}]}"
		fi
	done
	
	### return value ###
	eval "${rtn_var}=\"${_arrayJoin}\"" 	# return value in FUNCTION_NAME or RETURN_VAR
	dk_return "${_arrayJoin}"				# return value in COMMAND_SUBSTITUTION
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myArray[0]="a b c"
	myArray[1]="1 2 3"
	myArray[2]="d e f"
	myArray[3]="4 5 6"
	myArray[4]="h i j"
	
	# return value in FUNCTION_NAME
	dk_call dk_arrayJoin myArray
	dk_call dk_printVar dk_arrayJoin
	[ "${dk_arrayJoin}" = "a b c,1 2 3,d e f,4 5 6,h i j" ] && dk_call dk_success "dk_arrayJoin() suceeded" || dk_call dk_error "dk_arrayJoin() failed"
	
	# return value in RETURN_VAR
	dk_call dk_arrayJoin myArray "," rv_arrayJoin
	dk_call dk_printVar rv_arrayJoin
	[ "${rv_arrayJoin}" = "a b c,1 2 3,d e f,4 5 6,h i j" ] && dk_call dk_success "dk_arrayJoin() suceeded" || dk_call dk_error "dk_arrayJoin() failed"
	
	# return value in COMMAND_SUBSTITUTION
	cs_arrayAt=$(dk_call dk_arrayJoin myArray ",")
	dk_call dk_printVar cs_arrayAt
	[ "${cs_arrayAt}" = "a b c,1 2 3,d e f,4 5 6,h i j" ] && dk_call dk_success "dk_arrayJoin() suceeded" || dk_call dk_error "dk_arrayJoin() failed"
}
