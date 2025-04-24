<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

##################################################################################
# dk_toLower(<input> <output>)
#
#
dk_toLower() {
	dk_debugFunc 1 2

	local _toLower_=$(builtin echo "${1}" | tr '[:upper:]' '[:lower:]')
<<<<<<< HEAD
=======
	echo "_toLower_ = ${_toLower_}"
>>>>>>> Development
	
	### return value ###
	dk_call dk_printVar _toLower_
	[ ${#} -gt 1 ] && eval "${2}=${_toLower_}" && return  # return value when using rtn_var parameter 
<<<<<<< HEAD
	dk_return ${_toLower_}; return						  # return value when using command substitution
=======
	dk_return "${_toLower_}"; return						  # return value when using command substitution
>>>>>>> Development
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
<<<<<<< HEAD
	dk_call dk_toLower "CoNvErT tHiS sTrInG tO aLl LoWeRcAse" lowercase
=======
	myVar="CoNvErT sTrInG tO aLl LoWeRcAse"
	echo "myVar = ${myVar,,}"  # bash 4.0+ for easy method
	
	myVar="CoNvErT sTrInG tO aLl LoWeRcAse"
	lowercase="$(dk_call dk_toLower "${myVar}")"
	echo "lowercase = ${lowercase}"
	
	myVar="CoNvErT sTrInG tO aLl LoWeRcAse"
	dk_call dk_toLower "${myVar}" lowercase
>>>>>>> Development
	echo "lowercase = ${lowercase}"
}
