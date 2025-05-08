#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


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
	[ -n "${3-}" ] && local rtn_var="${3}" || local rtn_var="dk_arrayConcat"
	
	
	_arrayConcat=("${arrayA[@]}" "${arrayB[@]}");

	### return value ###
	eval ${rtn_var}='("${_arrayConcat[@]}")'	# return value in FUNCTION_NAME or RETURN_VAR
	dk_return "${_arrayConcat[*]}"				# return value in COMMAND_SUBSTITUTION
	
	# #NOTE: IFS=$'\n' must be call in parent before COMMAND_SUBSTITUTION 
	# EXAMPLE
	# 	IFS=$'\n'
	# 	myNewArry=($(dk_call dk_arrayConcat array1 array2))
	# 	IFS=$' \t\n'
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myArray1[0]="a b c"
	myArray1[1]="d e f"
	myArray1[2]="g h i"
	dk_call dk_printVar myArray1
	
	myArray2[0]="1 2 3"
	myArray2[1]="4 5 6"
	myArray2[2]="7 8 9"
	dk_call dk_printVar myArray2
	
	# return value in FUNCTION_NAME
	dk_call dk_arrayConcat myArray1 myArray2
	dk_call dk_printVar dk_arrayConcat
	[ "${dk_arrayConcat[0]-}" = "a b c" ] && \
	[ "${dk_arrayConcat[1]-}" = "d e f" ] && \
	[ "${dk_arrayConcat[2]-}" = "g h i" ] && \
	[ "${dk_arrayConcat[3]-}" = "1 2 3" ] && \
	[ "${dk_arrayConcat[4]-}" = "4 5 6" ] && \
	[ "${dk_arrayConcat[5]-}" = "7 8 9" ] && \
	dk_call dk_success "dk_arrayConcat succeeded" || \
	dk_call dk_error "dk_arrayConcat failed"
	
	# return value in RETURN_VAR
	dk_call dk_arrayConcat myArray1 myArray2 rv_arrayConcat
	dk_call dk_printVar rv_arrayConcat
	[ "${rv_arrayConcat[0]-}" = "a b c" ] && \
	[ "${rv_arrayConcat[1]-}" = "d e f" ] && \
	[ "${rv_arrayConcat[2]-}" = "g h i" ] && \
	[ "${rv_arrayConcat[3]-}" = "1 2 3" ] && \
	[ "${rv_arrayConcat[4]-}" = "4 5 6" ] && \
	[ "${rv_arrayConcat[5]-}" = "7 8 9" ] && \
	dk_call dk_success "dk_arrayConcat succeeded" || \
	dk_call dk_error "dk_arrayConcat failed"
	
	# return value in COMMAND_SUBSTITUTION
	IFS=$'\n'
	cs_arrayConcat=($(dk_call dk_arrayConcat myArray1 myArray2))
	IFS=$' \t\n'
	dk_call dk_printVar cs_arrayConcat
	[ "${cs_arrayConcat[0]-}" = "a b c" ] && \
	[ "${cs_arrayConcat[1]-}" = "d e f" ] && \
	[ "${cs_arrayConcat[2]-}" = "g h i" ] && \
	[ "${cs_arrayConcat[3]-}" = "1 2 3" ] && \
	[ "${cs_arrayConcat[4]-}" = "4 5 6" ] && \
	[ "${cs_arrayConcat[5]-}" = "7 8 9" ] && \
	dk_call dk_success "dk_arrayConcat succeeded" || \
	dk_call dk_error "dk_arrayConcat failed"
	
	# return value in COMMAND_SUBSTITUTION without IFS=$'\n'
	# ######### FIXME #########
	#cs_arrayConcat_B=($(dk_call dk_arrayConcat myArray1 myArray2))
	#dk_call dk_printVar cs_arrayConcat_B
	#[ "${cs_arrayConcat_B[0]-}" = "a b c" ] && \
	#[ "${cs_arrayConcat_B[1]-}" = "d e f" ] && \
	#[ "${cs_arrayConcat_B[2]-}" = "g h i" ] && \
	#[ "${cs_arrayConcat_B[3]-}" = "1 2 3" ] && \
	#[ "${cs_arrayConcat_B[4]-}" = "4 5 6" ] && \
	#[ "${cs_arrayConcat_B[5]-}" = "7 8 9" ] && \
	#dk_call dk_success "dk_arrayConcat succeeded" || \
	#dk_call dk_error "dk_arrayConcat failed"
}
