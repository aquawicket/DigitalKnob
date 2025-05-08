#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##############################################################################
# dk_isNumber(arg) -> rtn_var
# 
#	Test if arg1 is a number or a number variable
#
#	${1}			- The variable to test
#	${rtn_var}: 	- True if the argument is string or a string variable
#
dk_isNumber() {
	dk_debugFunc 1
	
	re='^[0-9]+$'
	dk_isVariable ${1} && local var=${!1} || local var=${1}

	[[ ${var} =~ ${re} ]] && return $(true) || return $(false)
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myNumber1=69
	dk_isNumber myNumber1 && dk_echo "myNumber1 is a number" || dk_echo "myNumber1 is NOT a number"
	dk_isNumber 23        && dk_echo "23 is a number"        || dk_echo "23 is NOT a number"
	dk_isNumber 123.456   && dk_echo "123.456 is a number"   || dk_echo "123.456 is NOT a number"
	dk_isNumber 0         && dk_echo "0 is a number"         || dk_echo "0 is NOT a number"
	dk_isNumber 1         && dk_echo "1 is a number"         || dk_echo "1 is NOT a number"
	
	#dk_echo "dk_isNumber myNumber1 = $(dk_isNumber myNumber1)"
	
	#if dk_isNumber myNumber1; then
	#	dk_echo "myNumber1 is a number"
	#else
	#	dk_echo "myNumber1 is NOT a number"
	#fi
}
