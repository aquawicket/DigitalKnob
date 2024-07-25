#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

################################################################################
# dk_arrayJoin(array, separator, rtn_var)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_join
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
#
dk_arrayJoin() {
	dk_debugFunc
	[ ${#} -lt 2 ] && dk_error "${FUNCNAME}(${#}): not enough arguments"
	[ ${#} -gt 3 ] && dk_error "${FUNCNAME}(${#}): too many arguments"
	#dk_validateArgs array string optional:rtn_var

	eval local array='("${'$1'[@]}")'			#typeset -n array=${1}
	for ((i=0; i < ${#array[@]}; i++ )); do
		if [ -z "${dk_arrayJoin-}" ]; then
			local dk_arrayJoin="${array[${i}]}"
		else
		    local dk_arrayJoin="${dk_arrayJoin}${2}${array[${i}]}"
		fi
	done
	
	[ ${#} -gt 2 ] && eval ${3}='"${dk_arrayJoin}"' && return
	dk_return "${dk_arrayJoin}" && return	
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc
	
	myArrayA[0]="a b c"
	myArrayA[1]="1 2 3"
	myArrayA[2]="d e f"
	myArrayA[3]="4 5 6"
	myArrayA[4]="h i j"
	
	dk_arrayJoin myArrayA "," myStringA
	dk_printVar myStringA
	
	
	myArrayB[0]="h i j"
	myArrayB[1]="4 5 6"
	myArrayB[2]="d e f"
	myArrayB[3]="1 2 3"
	myArrayB[4]="a b c"
	
	myStringB=$(dk_arrayJoin myArrayB ",")
	dk_printVar myStringB
}
