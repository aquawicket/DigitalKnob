#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_toVariableInfo(<message-var>)
#
#	If the parameter is a variable containing the name of a valid variable name
#	Convert the contents to the details of said variable
#
#	Example:  
#	myVar="this is my variable"
#	message="myVar"
#	dk_toVariableInfo message
#	echo $message
#
#	Output:
#	myVar: 'this is my variable'
#
dk_toVariableInfo () {
	dk_debugFunc
	[ $# -ne 1 ] && return #dk_echo "incorrect number or parameters" && return
	
	eval "name=\${$1}"
	$(expr "$name" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return		# ^ as first character is not portable
	#$(expr "${name}" : "[A-Za-z0-9_]\+$" 1>/dev/null) || return
	
	var_name="\${$name}"  #var_name is literal '${VARIABLE}'
	if dk_defined $name; then
		eval "value=\${$name}"
		eval "$1=\"\$var_name = '${value}'\""
	else
		eval "$1=\"\$var_name = ${red}UNDEFINED${clr}\""
	fi
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_toVariableInfo
}