#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayJoin(array, separator, rtn_var)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_join
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
#
dk_arrayJoin (){
	dk_debugFunc
	#[ ${#} -ne 3 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	dk_validateArgs array string optional:rtn_var
	
	#_arry_="${1}"
	#_separator_="${2}"
	
	#local arry=("${!1}")
	typeset -n arry=${1} 
	for ((i=0; i < ${#arry[@]}; i++ )); do
		if [ -z ${dk_arrayJoin-} ]; then
			local dk_arrayJoin="${arry[${i}]}"
		else
		    local dk_arrayJoin="${dk_arrayJoin}${2}${arry[${i}]}"
		fi
	done
	
	[ ${#} -gt 2 ] && eval "${3}=${dk_arrayJoin}"
	dk_return ${dk_arrayJoin}; return	
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArrayA[0]="a"
	myArrayA[1]="b"
	myArrayA[2]="c"
	myArrayA[3]="d"
	myArrayA[4]="e"
	
	#dk_arrayJoin myArrayA "," myStringA
	myStringA=$(dk_arrayJoin myArrayA ",")
	dk_echo "myStringA = ${myStringA}"
	
	
	
	myArrayB[0]="1"
	myArrayB[1]="2"
	myArrayB[2]="3"
	myArrayB[3]="4"
	myArrayB[4]="5"
	
	dk_arrayJoin myArrayB "," myStringB
	#myStringB=$(dk_arrayJoin myArrayB ",")
	dk_echo "myStringB = ${myStringB}"
}
