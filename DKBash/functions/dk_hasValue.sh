# dk_includeGuard()

##################################################################################
# dk_hasValue(<variable>)
#
# Evaluates to true if the parameter is a variable that exists and has value
#
dk_hasValue () {
	dk_verbose "dk_hasValue($*)"
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"
	
	eval value='$'{$1}
	[ -n "${value//[[:blank:]]/}" ] # remove spaces and check if empty
}