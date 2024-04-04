#include_guard()

##################################################################################
# dk_validate_git()
#
#
function dk_validate_git() {
	dk_debug "dk_validate_git("$@")"
	if ! dk_command_exists git; then
		install git
	fi
	
	GIT_EXE=$(command -v git)
	print_var GIT_EXE
}