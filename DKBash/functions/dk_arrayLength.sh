#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_arrayLength(<array> <output>)
#
#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_length
#
dk_arrayLength () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	typeset -n arry=$1
	array_length=${#arry[@]}
	
	eval "$2=$array_length"
	dk_printVar $2
}




DKTEST(){ ########################################################################

	myArray=("element 1" "element 2" "element 3")
	dk_arrayLength myArray length
	echo "length = $length"
}