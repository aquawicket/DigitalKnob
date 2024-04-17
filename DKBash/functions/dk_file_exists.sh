# dk_include_guard()

##################################################################################
# dk_file_exists(<file>)
#
#
dk_file_exists () {
	dk_verbose "dk_file_exists($*)"
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"

	#if [ -e "$1" ]; then
	#	dk_debug "dk_file_exists($*): FOUND"
	#else
	#	dk_warning "dk_file_exists($*): NOT FOUND!" 
	#fi
	[ -e "$1" ]
}