#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##############################################################################
# dk_isString(arg) -> rtn_var
# 
#	Test if arg1 is a string or a string variable
#
#	${1}			- The variable to test
#	${rtn_var}: 	- True if the argument is string or a string variable
#
dk_isString (){
	dk_debugFunc 
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	re='^[0-9]+$'
	dk_isVariable ${1} && local var=${!1} || local var=${1}

	[[ ${var} =~ ${re} ]] && return $(true) || return $(false)
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc
	
	myString1="test string"
	dk_isString myString1        && echo "myString1 is a string"       || echo "myString1 is NOT a string"
	dk_isString "as string"      && echo "'as string' is a string"     || echo "'as string' is NOT a string"
	dk_isString no_quotes        && echo "no_quotes is a string"       || echo "no_quotes is NOT a string"
	dk_isString 'single quotes'  && echo "'single quotes' is a string" || echo "'single quotes' is NOT a string"
	dk_isString ""               && echo "1 is a string"               || echo "1 is NOT a string"
	
	#dk_echo "dk_isString myString1 = $(dk_isString myString1)"
	
	#if dk_isString myString1; then
	#	echo "myString1 is a string"
	#else
	#	echo "myString1 is NOT a string"
	#fi
}
