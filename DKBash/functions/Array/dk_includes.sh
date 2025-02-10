#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

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
	for ((index=0; index < ${#array[@]}; index++ )); do
		[ "${2}" = "${array[${index}]}" ] && return $(true)
	done
	return $(false)
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	array123=(1 2 3)
	dk_call dk_arrayIncludes array123 2     && echo "true" || echo "false" # true
	dk_call dk_arrayIncludes array123 4     && echo "true" || echo "false" # false
	#dk_call dk_arrayIncludes array123 3 3  && echo "true" || echo "false" # false
	#dk_call dk_arrayIncludes array123 3 -1 && echo "true" || echo "false" # true
	array12NaN=(1 2 NaN)
	dk_call dk_arrayIncludes array12NaN NaN && echo "true" || echo "false" # true
	array123q=("1" "2" "3")
	dk_call dk_arrayIncludes array123q 3    && echo "true" || echo "false" # false   # FIXME:  incorrect
}
