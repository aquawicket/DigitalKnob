dk_includeGuard

##################################################################################
# dk_toLower(<variable>)
#
#
dk_toLower () {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"
	
	dk_defined $1 || dk_error "dk_toLower($*): $1 is not defined"

	eval value='$'{$1}
	value=$(echo "$value" | tr '[:upper:]' '[:lower:]')

	eval "$1=$value"
}