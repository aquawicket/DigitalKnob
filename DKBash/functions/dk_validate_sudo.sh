# dk_include_guard()

##################################################################################
# dk_validate_sudo()
#
#
function dk_validate_sudo() {
	dk_debug "dk_validate_sudo($@)"
	if command -v "sudo" >/dev/null 2>&1; then
		SUDO="sudo"
	fi
	$SUDO echo
}