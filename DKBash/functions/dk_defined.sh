# dk_include_guard()

##################################################################################
# dk_defined(<variable>)
#
# Evaluates to true if the parameter is a variable that exists.
#
dk_defined () {
	dk_verbose "dk_defined($*)"
	[ $# -ne 1 ] && return $false # Incorrect number of parameters
	
	eval value='$'{$1+x} # value will = 'x' if the variable is defined
	[ -n "$value" ]
}