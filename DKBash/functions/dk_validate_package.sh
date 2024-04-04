#include_guard()

##################################################################################
# dk_validate_package()
#
#
function dk_validate_package() {
	dk_debug "dk_validate_package("$@")"
	if ! dk_command_exists $1; then
		install $2
	fi
}