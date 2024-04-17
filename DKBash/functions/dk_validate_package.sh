# dk_include_guard()

##################################################################################
# dk_validate_package(<command> <package>)
#
#
dk_validate_package () {
	dk_verbose "dk_validate_package($*)"
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	if ! dk_command_exists "$1"; then
		dk_install "$2"
	fi
}