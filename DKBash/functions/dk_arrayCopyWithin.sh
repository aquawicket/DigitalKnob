#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayCopyWithin(array, target, start)
# dk_arrayCopyWithin(array, target, start, end)
#
#	The dk_arrayCopyWithin() method copies part of this array to another location
#   in the same array and returns this array without modifying its length.
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin
#
dk_arrayCopyWithin (){
	dk_debugFunc
	#[ ${#} -ne 4 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	dk_validateArgs array any any any
	
	dk_todo "dk_arrayCopyWithin"
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_todo
	dk_arrayCopyWithin array target start end
}