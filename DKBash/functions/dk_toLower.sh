#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_toLower(<input> <output>)
#
#
dk_toLower() {
	dk_debugFunc 1 2

	local _toLower_=$(builtin echo "${1}" | tr '[:upper:]' '[:lower:]')
	echo "_toLower_ = ${_toLower_}"
	
	### return value ###
	dk_call dk_printVar _toLower_
	[ ${#} -gt 1 ] && eval "${2}=${_toLower_}" && return  # return value when using rtn_var parameter 
	dk_return "${_toLower_}"; return						  # return value when using command substitution
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myVar="CoNvErT sTrInG tO aLl LoWeRcAse"
	echo "myVar = ${myVar,,}"  # bash 4.0+ for easy method
	
	myVar="CoNvErT sTrInG tO aLl LoWeRcAse"
	lowercase="$(dk_call dk_toLower "${myVar}")"
	echo "lowercase = ${lowercase}"
	
	myVar="CoNvErT sTrInG tO aLl LoWeRcAse"
	dk_call dk_toLower "${myVar}" lowercase
	echo "lowercase = ${lowercase}"
}
