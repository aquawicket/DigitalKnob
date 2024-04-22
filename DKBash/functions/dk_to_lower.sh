# dk_include_guard()

##################################################################################
# dk_to_lower(<variable>)
#
#
dk_to_lower () {
	dk_verbose "dk_to_lower($*)"
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"
	
	dk_defined $1 || dk_error "dk_to_lower($*): $1 is not defined"

	eval value='$'{$1}
	value=$(echo "$value" | tr '[:upper:]' '[:lower:]')

	eval "$1=$value"
}