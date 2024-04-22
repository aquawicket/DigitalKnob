# dk_include_guard()

##################################################################################
# dk_get_filename(<path> <output>)
#
#
dk_get_filename () {
	dk_verbose "dk_get_filename($*)"
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	eval "$2=$(basename "$1")"
}