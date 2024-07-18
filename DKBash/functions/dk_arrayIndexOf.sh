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
dk_arrayIndexOf() {
	dk_debugFunc
	[ ${#} -ne 3 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	#dk_validateArgs array element optional:rtn_var
	
	eval local array=('${'$1'[@]}')			#typeset -n array=${1}
	for ((arrayIndexOf=0; arrayIndexOf < ${#array[@]}; arrayIndexOf++ )); do
		if [ "${2}" = "${array[${arrayIndexOf}]}" ]; then
		
			# return value
			[ ${#} -gt 2 ] && eval "${3}=${arrayIndexOf}" 
			dk_return ${arrayIndexOf}; return
		fi
	done
	local arrayIndexOf=-1
	[ ${#} -gt 2 ] && eval "${3}=${arrayIndexOf}" 
	dk_return ${arrayIndexOf}; return
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc
	
	myArrayA[0]="a"
	myArrayA[1]="b"
	myArrayA[2]="c"
	myArrayA[3]="d"
	myArrayA[4]="e"
	
	dk_arrayIndexOf myArrayA "a" indexA
	dk_printVar indexA
	
	dk_arrayIndexOf myArrayA "b" indexB
	dk_printVar indexB
	
	dk_arrayIndexOf myArrayA "c" indexC
	dk_printVar indexC
	
	dk_arrayIndexOf myArrayA "d" indexD
	dk_printVar indexD
	
	dk_arrayIndexOf myArrayA "e" indexE
	dk_printVar indexE
	
	dk_arrayIndexOf myArrayA "nonExistant" indexN
	dk_printVar indexN
	
	
	
	
	
	myArrayB[0]="1"
	myArrayB[1]="2"
	myArrayB[2]="3"
	myArrayB[3]="4"
	myArrayB[4]="5"
	
	dk_arrayIndexOf myArrayB "1" indexAA
	dk_printVar indexAA
	
	dk_arrayIndexOf myArrayB "2" indexBB
	dk_printVar indexBB
	
	dk_arrayIndexOf myArrayB "3" indexCC
	dk_printVar indexCC
	
	dk_arrayIndexOf myArrayB "4" indexDD
	dk_printVar indexDD
	
	dk_arrayIndexOf myArrayB "5" indexEE
	dk_printVar indexEE
	
	dk_arrayIndexOf myArrayB "nonExistant" indexNN
	dk_printVar indexNN
}