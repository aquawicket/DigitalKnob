dk_includeGuard

##################################################################################
# dk_commandExists(<command>)
#
#
dk_commandExists () {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"

	[ -n "$(command -v "$1")" ]
}