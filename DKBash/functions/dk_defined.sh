#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_defined(variable)
#
# Evaluates to true if the parameter is a variable that exists.
#
dk_defined() {
	dk_debugFunc 1
	
	#$(expr "${1}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return ${false}   # ^ as first character is not portable
	# FIXME:  the errors out on zsh
	
	#$(expr "${1}" : "[A-Za-z0-9_]\+$" 1>/dev/null) || return ${false}		# if not valid variable name
	#[[ ${1} ~= [A-Za-z0-9_]\+$ ]] || return ${false}
	
	#dk_call dk_echo "${green}${name} is [:word:]${clr}"
	
	#eval value='$'{${1}+x} # value will = 'x' if the variable is defined
	
	[ -n "${!1+1}" ]
	#dk_call dk_echo "dk_defined():value = ${value}"
	#[ -n "${value}" ]
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	varA="A simple string variable"
	if dk_call dk_defined varA; then
		dk_call dk_echo "varA is defined"
	else
		dk_call dk_echo "varA is NOT defined"
	fi
	
	#varB="A non existent variable"
	if dk_call dk_defined varB; then
		dk_call dk_echo "varB is defined"
	else
		dk_call dk_echo "varB is NOT defined"
	fi
}
