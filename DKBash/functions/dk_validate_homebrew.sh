# dk_include_guard()

##################################################################################
# dk_validate_homebrew()
#
#
dk_validate_homebrew () {
	dk_verbose "dk_validate_homebrew($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	if ! [ "$OSTYPE" = "darwin"* ]; then
		return
	fi
		
	if ! dk_command_exists brew; then
		dk_info "dk_installing Homebrew"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/dk_install/master/dk_install)"
		# https://github.com/Homebrew/brew/issues/10368
		rm -fr $(brew --repo homebrew/core)
		brew tap homebrew/core
	fi
	
	BREW=$(command -v brew)
	dk_debug BREW
}