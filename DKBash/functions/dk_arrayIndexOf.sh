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
	[ ${#} -lt 2 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	[ ${#} -gt 4 ] && dk_error "${FUNCNAME}(${#}): too many arguments"
	#dk_validateArgs array element optional:rtn_var
	
	eval local array='("${'$1'[@]}")'			#typeset -n array=${1}
	for ((arrayIndexOf=0; arrayIndexOf < ${#array[@]}; arrayIndexOf++ )); do
		if [ "${2}" = "${array[${arrayIndexOf}]}" ]; then
		
			# return value
			[ ${#} -gt 2 ] && eval ${3}=${arrayIndexOf} && return 
			dk_return ${arrayIndexOf} && return
		fi
	done
	local arrayIndexOf=-1
	[ ${#} -gt 2 ] && eval ${3}=${arrayIndexOf} && return
	dk_return ${arrayIndexOf} && return
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc
	
	myArrayA[0]="a b c"
	myArrayA[1]="1 2 3"
	myArrayA[2]="d e f"
	myArrayA[3]="4 5 6"
	myArrayA[4]="h i j"
	
	dk_arrayIndexOf myArrayA "a b c" indexABC
	dk_printVar indexABC
	
	dk_arrayIndexOf myArrayA "1 2 3" index123
	dk_printVar index123
	
	dk_arrayIndexOf myArrayA "d e f" indexDEF
	dk_printVar indexDEF
	
	dk_arrayIndexOf myArrayA "4 5 6" index456
	dk_printVar index456
	
	dk_arrayIndexOf myArrayA "h i j" indexHIJ
	dk_printVar indexHIJ
	
	dk_arrayIndexOf myArrayA "nonExistant" indexN
	dk_printVar indexN
	
	
	myArrayB[0]="h i j"
	myArrayB[1]="4 5 6"
	myArrayB[2]="d e f"
	myArrayB[3]="1 2 3"
	myArrayB[4]="a b c"
	
	
	indexABC2=$(dk_arrayIndexOf myArrayB "a b c")
	dk_printVar indexABC2
	
	index123B=$(dk_arrayIndexOf myArrayB "1 2 3")
	dk_printVar index123B
	
	indexDEF2=$(dk_arrayIndexOf myArrayB "d e f")
	dk_printVar indexDEF2
	
	index456B=$(dk_arrayIndexOf myArrayB "4 5 6")
	dk_printVar index456B
	
	indexHIJ2=$(dk_arrayIndexOf myArrayB "h i j")
	dk_printVar indexHIJ2
	
	indexNN=$(dk_arrayIndexOf myArrayB "nonExistant")
	dk_printVar indexNN
}