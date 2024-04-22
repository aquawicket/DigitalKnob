# dk_include_guard()

##################################################################################
# dk_commandExists(<command>)
#
#
dk_commandExists () {
	dk_verbose "dk_commandExists($*)"
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"

	[ -n "$(command -v "$1")" ]
}