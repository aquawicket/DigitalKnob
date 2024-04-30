dk_includeGuard

###############################################################################
# dk_validate(variable func)
#
#	@variable  - The name of a variable to test
#	@func	   - The function to run if the variable is invalid.
#
dk_validate () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"

	[ -n $1 ] && return
	$2
}