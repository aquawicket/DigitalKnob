# dk_include_guard()

##################################################################################
# dk_command_exists(<command>)
#
#
dk_command_exists () {
	dk_verbose "dk_command_exists($*)"
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"

	[ -n "$(command -v "$1")" ]
}