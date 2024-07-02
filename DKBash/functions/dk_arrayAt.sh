#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_arrayAt(array, index, rtn_var)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_at
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
dk_arrayAt (){
	dk_debugFunc
	#[ $# -ne 3 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	dk_validateArgs array int optional:rtn_var
	
	typeset -n arry=${1} 
	local arrayAt="${arry[${2}]}"
	
	dk_printVar arrayAt
	[ $# -gt 2 ] && eval "${3}=${arrayAt}"
	dk_return ${arrayAt}
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArray[0]="a"
	myArray[1]="b"
	myArray[2]="c"
	myArray[3]="d"
	myArray[4]="e"
	
	dk_arrayAt myArray 3 element
	dk_echo "element = ${element}"
}