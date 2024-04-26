dk_includeGuard

##################################################################################
# dk_set()
#
#
dk_set() {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"

	export $1=$2
}