dk_includeGuard

##################################################################################
# dk_defined(<variable>)
#
# Evaluates to true if the parameter is a variable that exists.
#
dk_defined () {
	dk_debugFunc

	[ $# -ne 1 ] && return $false # Incorrect number of parameters
	
	#echo "dk_defined():1 = $1"
	#$(expr "$1" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $false		# ^ as first character is not portable
	$(expr "$1" : "[A-Za-z0-9_]\+$" 1>/dev/null) || return $false		# if not valid variable name
	#echo "${green}$name is [:word:]${clr}"
	
	eval value='$'{$1+x} # value will = 'x' if the variable is defined
	
	#echo "dk_defined():value = $value"
	[ -n "$value" ]
}