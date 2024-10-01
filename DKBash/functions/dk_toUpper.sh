#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_toUpper(<input> <output>)
#
#
dk_toUpper() {
	dk_debugFunc 1 2

	local _toUpper_=$(builtin echo "${1}" | tr '[:lower:]' '[:upper:]')
	
	### return value ###
	dk_call dk_printVar _toUpper_
	[ ${#} -gt 1 ] && eval "${2}=${_toUpper_}" && return  # return value when using rtn_var parameter 
	dk_return ${_toUpper_}; return						  # return value when using command substitution
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_toUpper "CoNvErT tHiS sTrInG tO aLl UpPeRcAsE" uppercase
	echo "uppercase = ${uppercase}"
}
