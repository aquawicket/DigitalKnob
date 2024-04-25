# dk_includeGuard

##################################################################################
# dk_toVariableInfo(<var>)
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
#	myVar = 'this is my variable'
#
dk_toVariableInfo () {
	#dk_debugFunc
	
	[ $# -ne 1 ] && return $false											# if not exactly 1 parameter
	
	#echo "1 = $1"
	eval name='$'{$1}
	#echo "dk_toVariableInfo():name1 = $name"
	$(expr "$name" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $false		# if not valid variable name
	#echo "${green}$name is [:word:]${clr}"

	if dk_defined $name; then
		#echo "dk_toVariableInfo():name = $name"
		eval value='$'{$name}
		eval "$1=\"$name = '${value}'\""
	else
		eval "$1=\"$name = ${red}NOT DEFINED${clr}\""
	fi
}