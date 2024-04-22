# dk_include_guard()

##################################################################################
# dk_install(<package>)
#
#
dk_install () {
	dk_verbose "dk_install($*)"
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"

	#if dk_package_installed $1; then
	#	dk_warning "$1 already dk_installed"
	#	return $false;
	#fi
	
	dk_info "dk_installing $1"

	if dk_command_exists brew; then
		dk_call $SUDO brew dk_install "$1"
	elif dk_command_exists apt; then
		dk_call $SUDO apt -y dk_install "$1"
	elif dk_command_exists apt-get; then
		dk_call $SUDO apt-get -y dk_install "$1"
	elif dk_command_exists pkg; then
		dk_call $SUDO pkg dk_install "$1"
	elif dk_command_exists pacman; then
		dk_call $SUDO pacman -S "$1" --noconfirm
	elif dk_command_exists tce-load; then
		dk_call $SUDO tce-load -wi "$1"
	else
		dk_error "ERROR: no package managers found"
	fi
}