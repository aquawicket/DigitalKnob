#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_arrayCopyWithin(array, target, start, end)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_copywithin
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin
#
dk_arrayCopyWithin () {
	dk_debugFunc
	[ $# -ne 4 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	dk_todo "dk_arrayCopyWithin"
}




DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_arrayCopyWithin array target start end
}