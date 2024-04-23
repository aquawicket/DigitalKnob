# dk_include_guard()

##################################################################################
# dk_getFilename(<path> <output>)
#
#
dk_getFilename () {
	dk_verbose "dk_getFilename($*)"
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	eval "$2=$(basename "$1")"
}