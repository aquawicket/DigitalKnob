#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

################################################################################
# dk_at(array, index)
# dk_at(array, index, rtn_var)
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
dk_at() {
	dk_debugFunc 2 3
	#dk_call dk_validateArgs array int optional:rtn_var
	
	#eval local arrayAt='("${'${1}'[${2}]}")'
	eval local arrayAt='${'${1}'[${2}]}'
	
	### return value ###
	#[ ${#} -gt 2 ] && eval ${3}='"${arrayAt}"' && return	# return value using return variable
	[ ${#} -gt 2 ] && eval ${3}='${'${1}'[${2}]}' && return	# return value using return variable
	dk_return "${arrayAt}" && return						# return value using command substitution
	#dk_return "${"${1}"[${2}]}" && return					# return value using command substitution
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myArrayA[0]="a b c"
	myArrayA[1]="1 2 3"
	myArrayA[2]="d e f"
	myArrayA[3]="4 5 6"
	myArrayA[4]="h i j"
	dk_call dk_printVar myArrayA
	dk_call dk_at myArrayA 2 arrayAtA	# returned value using return variable
	dk_call dk_printVar arrayAtA
	dk_call dk_echo "dk_arrayAt(MyArrayA 2) = ${arrayAtA}"
	[ "${arrayAtA}" = "d e f" ] || dk_call dk_error "dk_arrayAt() failed"
	[ "${arrayAtA}" = "d e f" ] && dk_call dk_info "dk_arrayAt() suceeded" 
	
	myArrayB[0]="h i j"
	myArrayB[1]="4 5 6"
	myArrayB[2]="d e f"
	myArrayB[3]="1 2 3"
	myArrayB[4]="a b c"
	dk_call dk_printVar myArrayB
	arrayAtB=$(dk_call dk_at myArrayB 3)	# returned value using command substitution
	dk_call dk_printVar arrayAtB
	dk_call dk_echo "dk_arrayAt(MyArrayB 3) = ${arrayAtB}"
	[ "${arrayAtB}" = "1 2 3" ] || dk_call dk_error "dk_arrayAt() failed"
	[ "${arrayAtB}" = "1 2 3" ] && dk_call dk_info "dk_arrayAt() suceeded"
}
