# dk_include_guard()

##################################################################################
# dk_has_value(<variable>)
#
# Evaluates to true if the parameter is a variable that exists and has value
#
dk_has_value () {
	dk_verbose "dk_has_value($*)"
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"
	
	eval value='$'{$1}
	[ -n "${value//[[:blank:]]/}" ] # remove spaces and check if empty
}