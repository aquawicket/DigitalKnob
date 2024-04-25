dk_includeGuard

##################################################################################
# dk_validatePackage(<command> <package>)
#
#
dk_validatePackage () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	if ! dk_commandExists "$1"; then
		dk_install "$2"
	fi
}