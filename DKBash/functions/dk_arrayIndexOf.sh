#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


################################################################################
# dk_arrayIndexOf(array, searchElement)
# dk_arrayIndexOf(array, searchElement, rtn_val)
# dk_arrayIndexOf(array, searchElement, fromIndex)
# dk_arrayIndexOf(array, searchElement, fromIndex, rtn_val)
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
#
dk_arrayIndexOf (){
	dk_debugFunc
	#[ $# -ne 3 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	dk_validateArgs array element optional:rtn_var
	
	typeset -n arry=${1} 
	for ((arrayIndexOf=0; arrayIndexOf < ${#arry[@]}; arrayIndexOf++ )); do
		if [ "${2}" = "${arry[${arrayIndexOf}]}" ]; then
		
			# return value
			[ $# -gt 2 ] && eval "${3}=${arrayIndexOf}" 
			dk_return ${arrayIndexOf}; return
		fi
	done
	local arrayIndexOf=-1
	[ ${#} -gt 2 ] && eval "${3}=${arrayIndexOf}" 
	dk_return ${arrayIndexOf}; return
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArrayA[0]="a"
	myArrayA[1]="b"
	myArrayA[2]="c"
	myArrayA[3]="d"
	myArrayA[4]="e"
	
	dk_arrayIndexOf myArrayA "a" indexA
	dk_echo "indexA = ${indexA}"
	
	dk_arrayIndexOf myArrayA "b" indexB
	dk_echo "indexB = ${indexB}"
	
	dk_arrayIndexOf myArrayA "c" indexC
	dk_echo "indexC = ${indexC}"
	
	dk_arrayIndexOf myArrayA "d" indexD
	dk_echo "indexD = ${indexD}"
	
	dk_arrayIndexOf myArrayA "e" indexE
	dk_echo "indexE = ${indexE}"
	
	dk_arrayIndexOf myArrayA "nonExistant" indexN
	dk_echo "indexN = ${indexN}"
	
	
	
	
	
	myArrayB[0]="1"
	myArrayB[1]="2"
	myArrayB[2]="3"
	myArrayB[3]="4"
	myArrayB[4]="5"
	
	dk_arrayIndexOf myArrayB "1" indexAA
	dk_echo "indexAA = ${indexAA}"
	
	dk_arrayIndexOf myArrayB "2" indexBB
	dk_echo "indexBB = ${indexBB}"
	
	dk_arrayIndexOf myArrayB "3" indexCC
	dk_echo "indexCC = ${indexCC}"
	
	dk_arrayIndexOf myArrayB "4" indexDD
	dk_echo "indexDD = ${indexDD}"
	
	dk_arrayIndexOf myArrayB "5" indexEE
	dk_echo "indexEE = ${indexEE}"
	
	dk_arrayIndexOf myArrayB "nonExistant" indexNN
	dk_echo "indexNN = ${indexNN}"
}