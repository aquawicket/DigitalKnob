# dk_include_guard()

##################################################################################
# dk_variable_info(<var>)
#
#	If var is the name of a valid variable, it will be converted
#	to a string containing "VAR = VALUE" 
#
dk_variable_info () {
	#dk_verbose "dk_variable_info($*)"
	
	if expr "$1" : "^[A-Za-z0-9_]\+$" 1>/dev/null; then  # [A-Za-z0-9_] == [:word:]
		if dk_defined $1; then
			eval value='$'{$1}
			msg="$1 = '${value}'"
		else
			msg="$1 = ${red}NOT DEFINED${clr}"
		fi
	fi
	eval "$1=$msg"
}