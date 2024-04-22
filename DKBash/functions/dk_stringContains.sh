# dk_includeGuard()

##################################################################################
# dk_stringContains(<string> <substring>)
#
#
dk_stringContains () {
	dk_verbose "dk_stringContains($*)"
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	# https://stackoverflow.com/a/8811800/688352
	string=$1
	substring=$2
	[ "${string#*"$substring"}" != "$string" ]	
}