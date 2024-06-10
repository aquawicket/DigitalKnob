#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_arrayAt(array, index, element)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_at
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
dk_arrayAt () {
	dk_debugFunc
	[ $# -ne 3 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	typeset -n arry=$1 
	rtn_var="${arry[$2]}"
	eval "$3=${rtn_var}"
}




DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	MyArray[0]="a"
	MyArray[1]="b"
	MyArray[2]="c"
	MyArray[3]="d"
	MyArray[4]="e"
	
	dk_arrayAt MyArray 3 element
	dk_echo "element = ${element}"
}