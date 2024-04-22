# dk_include_guard()

##################################################################################
# dk_validate_sudo()
#
#
dk_validate_sudo () {
	dk_verbose "dk_validate_sudo($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	if command -v "sudo" >/dev/null 2>&1; then
		SUDO="sudo"
	fi
	${SUDO-} echo
}