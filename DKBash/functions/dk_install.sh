#include_guard()

##################################################################################
# dk_install()
#
#
function dk_install() {
	dk_debug "dk_install("$@")"
	#if package_installed $1; then
	#	echo "$1 already installed"
	#	return $false;
	#fi
	
	echo "installing $1"

	if dk_command_exists brew; then
		dk_call $SUDO brew install $1
	elif dk_command_exists apt; then
		dk_call $SUDO apt -y install $1
	elif dk_command_exists apt-get; then
		echo "found apt-get"
		dk_call $SUDO apt-get -y install $1
	elif dk_command_exists pkg; then
		dk_call $SUDO pkg install $1
	elif dk_command_exists pacman; then
		dk_call $SUDO pacman -S $1 --noconfirm
	elif dk_command_exists tce-load; then
		dk_call $SUDO tce-load -wi $1
	else
		dk_error "ERROR: no package managers found"
	fi
}