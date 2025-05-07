#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

################################################################################
# dk_arrayIncludes(array, searchElement)
# dk_arrayIncludes(array, searchElement, fromIndex)
#
#    The includes() method of Array instances determines whether an array includes a certain value among its entries, returning true or false as appropriate.
#
#    PARAMETERS
#    searchElement
#        The value to search for.
#
#    fromIndex :optional
#        Zero-based index at which to start searching, converted to an integer.
#            Negative index counts back from the end of the array — if -array.length <= fromIndex < 0, fromIndex + array.length is used. However, 
#            the array is still searched from front to back in this case.
#            If fromIndex < -array.length or fromIndex is omitted, 0 is used, causing the entire array to be searched.
#            If fromIndex >= array.length, the array is not searched and false is returned.
#
#    RETURN VALUE
#    A boolean value which is true if the value searchElement is found within the array (or the part of the array indicated by the index fromIndex, if specified).
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes
#
dk_arrayIncludes() {
	dk_debugFunc 2 3
	#dk_call dk_validateArgs array string
	
	eval local array='("${'$1'[@]}")'			#typeset -n array=${1}
	local searchElement="${2}"
	[ -n "${3-}" ] && local fromIndex=${3-} || local fromIndex=0
	
	for ((index=${fromIndex}; index < ${#array[@]}; index++ )); do
		if [ "${searchElement}" = "${array[${index}]}" ]; then
			
			### return true ###
			eval dk_arrayIncludes="true"
			return $($dk_arrayIncludes)
		fi
	done
	
	### return false ###
	eval dk_arrayIncludes='false'
    set +o errexit
	trap '' ERR
	return $($dk_arrayIncludes) & set -o errexit
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myArray=(1 2 3 NaN)
	dk_call dk_arrayIncludes myArray 2 1
	dk_call dk_printVar dk_arrayIncludes
	[ "$dk_arrayIncludes" = "true" ] && dk_call dk_success "dk_arrayIncludes() suceeded" || dk_call dk_echo "dk_arrayIncludes() failed"
	$($dk_arrayIncludes) && dk_call dk_success "dk_arrayIncludes() suceeded" || dk_call dk_echo "dk_arrayIncludes() failed"
	
	dk_call dk_arrayIncludes myArray 4
	dk_call dk_printVar dk_arrayIncludes
	[ "$dk_arrayIncludes" = "false" ] && dk_call dk_success "dk_arrayIncludes() suceeded" || dk_call dk_echo "dk_arrayIncludes() failed"
	$($dk_arrayIncludes) && dk_call dk_echo "dk_arrayIncludes() failed" || dk_call dk_success "dk_arrayIncludes() suceeded"
	
	dk_call dk_arrayIncludes myArray NaN
	dk_call dk_printVar dk_arrayIncludes
	[ "$dk_arrayIncludes" = "true" ] && dk_call dk_success "dk_arrayIncludes() suceeded" || dk_call dk_echo "dk_arrayIncludes() failed"
	$($dk_arrayIncludes) && dk_call dk_success "dk_arrayIncludes() suceeded" || dk_call dk_echo "dk_arrayIncludes() failed"
	
	myArrayB=("1" "2" "3")
	dk_call dk_arrayIncludes myArrayB 3
	dk_call dk_printVar dk_arrayIncludes
	[ "$dk_arrayIncludes" = "false" ] && dk_call dk_success "dk_arrayIncludes() suceeded" || dk_call dk_echo "dk_arrayIncludes() failed"
	$($dk_arrayIncludes) && dk_call dk_echo "dk_arrayIncludes() failed" || dk_call dk_success "dk_arrayIncludes() suceeded"
}
