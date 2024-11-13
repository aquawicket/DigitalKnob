#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"


##################################################################################
# dk_isVariable(arg)
#
#
dk_isVariable() {
	dk_debugFunc 1
	
	#$(expr "${1}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)   	# ^ as first character is not portable
	$(expr "${1}" : "[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# if not valid variable name
	#dk_echo "${green}${name} is [:word:]${clr}"
	
	eval value='$'{${1}+x} 	# value will = 'x' if the variable is defined
	[ -n "${value}" ]
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	varA="A simple string variable"
	if dk_isVariable varA; then
		dk_echo "varA is a variable"
	else
		dk_echo "varA is NOT a variable"
	fi
	
	#varB="A non existent variable"
	if dk_isVariable varB; then
		dk_echo "varB is a variable"
	else
		dk_echo "varB is NOT a variable"
	fi
}
