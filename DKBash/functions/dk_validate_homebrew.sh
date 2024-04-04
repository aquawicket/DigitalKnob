#include_guard()

##################################################################################
# dk_validate_homebrew()
#
#
function dk_validate_homebrew() {
	dk_debug "dk_validate_homebrew("$@")"
	if ! [[ "$OSTYPE" == "darwin"* ]]; then
		return
	fi
		
	if ! dk_command_exists brew; then
		echo "installing Homebrew"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		# https://github.com/Homebrew/brew/issues/10368
		rm -fr $(brew --repo homebrew/core)
		brew tap homebrew/core
	fi
	
	BREW=$(command -v brew)
	print_var BREW
}