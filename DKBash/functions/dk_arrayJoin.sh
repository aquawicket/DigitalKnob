#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

################################################################################
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
	dk_debugFunc 2 3
	#dk_call dk_validateArgs array string optional:rtn_var

	eval local _array_='("${'$1'[@]}")'			#typeset -n _array_=${1}
	for ((i=0; i < ${#_array_[@]}; i++ )); do
		if [ -z "${arrayJoin-}" ]; then
			local arrayJoin="${_array_[${i}]}"
		else
		    local arrayJoin="${arrayJoin}${2}${_array_[${i}]}"
		fi
	done
	
	[ ${#} -gt 2 ] && eval ${3}='"${arrayJoin}"' && return
	dk_return "${arrayJoin}" && return	
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myArrayA[0]="a b c"
	myArrayA[1]="1 2 3"
	myArrayA[2]="d e f"
	myArrayA[3]="4 5 6"
	myArrayA[4]="h i j"
	
	dk_call dk_arrayJoin myArrayA "," myStringA
	dk_call dk_printVar myStringA
	
	
	myArrayB[0]="h i j"
	myArrayB[1]="4 5 6"
	myArrayB[2]="d e f"
	myArrayB[3]="1 2 3"
	myArrayB[4]="a b c"
	
	myStringB=$(dk_call dk_arrayJoin myArrayB ",")
	dk_call dk_printVar myStringB
}
