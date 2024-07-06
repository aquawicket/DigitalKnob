#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayAt(array, index)
# dk_arrayAt(array, index, rtn_var)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_at
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/at
#
dk_arrayAt (){
	dk_debugFunc
	#[ ${#} -ne 3 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	dk_validateArgs array int optional:rtn_var
	
	#eval local arry=('${'$1'[@]}')
	typeset -n arry=${1}
	
	local arrayAt="${arry[${2}]}"
	dk_printVar arrayAt
	
	# return value
	[ ${#} -gt 2 ] && eval "${3}=${arrayAt}"
	dk_return ${arrayAt}; return
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArrayA[0]="a"
	myArrayA[1]="b"
	myArrayA[2]="c"
	myArrayA[3]="d"
	myArrayA[4]="e"
	
	#dk_arrayAt myArrayA 3 elementA
	elementA=$(dk_arrayAt myArrayA)
	dk_echo "elementA = ${elementA}"
	
	
	
	
	myArrayB[0]="1"
	myArrayB[1]="2"
	myArrayB[2]="3"
	myArrayB[3]="4"
	myArrayB[4]="5"
	
	dk_arrayAt myArrayB 3 elementB
	#elementB=$(dk_arrayAt myArrayB 3)
	dk_echo "elementB = ${elementB}"
}