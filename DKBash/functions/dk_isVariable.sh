#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_isVariable(arg)
#
#
dk_isVariable (){
	dk_debugFunc
	[ ${#} -ne 1 ] && return ${false} # Incorrect number of parameters
	
	#$(expr "${1}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return ${false}   	# ^ as first character is not portable
	$(expr "${1}" : "[A-Za-z0-9_]\+$" 1>/dev/null) || return ${false}		# if not valid variable name
	#echo "${green}$name is [:word:]${clr}"
	
	eval value='$'{${1}+x} 	# value will = 'x' if the variable is defined
	[ -n "$value" ]
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc

	varA="A simple string variable"
	if dk_isVariable varA; then
		echo "varA is a variable"
	else
		echo "varA is NOT a variable"
	fi
	
	#varB="A non existent variable"
	if dk_isVariable varB; then
		echo "varB is a variable"
	else
		echo "varB is NOT a variable"
	fi
}