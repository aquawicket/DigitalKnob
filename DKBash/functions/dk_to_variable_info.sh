# dk_include_guard()

##################################################################################
# dk_to_variable_info(<var>)
#
#	If the parameter is a variable containing the name of a valid variable name
#	Convert the contents to the details of said variable
#
#	Example:  
#	myVar="this is my variable"
#	message="myVar"
#	dk_to_variable_info message
#	echo $message
#
#	Output:
#	myVar = 'this is my variable'
#
dk_to_variable_info () {
	#echo "dk_to_variable_info($*)"
	
	[ $# -ne 1 ] && return $false											# if not exactly 1 parameter
	eval name='$'{$1}
	$(expr "$name" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $false		# if not valid variable name
	
	if dk_defined $name; then
		eval value='$'{$name}
		eval "$1=\"$name = '${value}'\""
	else
		eval "$1=\"$name = ${red}NOT DEFINED${clr}\""
	fi
}