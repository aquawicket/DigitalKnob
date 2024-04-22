# dk_include_guard()

##################################################################################
# dk_variable_info(<name> <output>)
#
#
dk_variable_info () {
	echo "dk_variable_info($*)"
	
	[ $# -ne 2 ] && return $false										# if not exactly 2 parameters
	$(expr "$1" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $false		# if not valid variable name
	$(expr "$2" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $false		# if not valid variable name
	
	if dk_defined $1; then
		eval value='$'{$1}
		eval "$2=\"$1 = '${value}'\""
	else
		eval "$2=\"$1 = ${red}NOT DEFINED${clr}\""
	fi
}