#include_guard()

##################################################################################
# dk_package_installed()
#
#
function dk_package_installed() {
	dk_debug "dk_package_installed($@)"
	if dk_command_exists dpkg-query; then
		if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -ne 0 ]; then
			return $true
		fi
	elif dk_command_exists brew; then
		if brew list $1 &>/dev/null; then
			return $true
		fi
	elif dk_command_exists apt; then
		dk_error "package_installed() apt-get not implemented"
	elif dk_command_exists apt-get; then
		dk_error "package_installed() apt-get not implemented"
	elif dk_command_exists pkg; then
		dk_error "package_installed() pkg not implemented"
	elif dk_command_exists pacman; then
		if pacman -Qs $1 > /dev/null; then
			#FIXME: this doesn't always work
			return $false;
		fi
	elif dk_command_exists tce-load; then
		#dk_error "package_installed() tce-load not implemented"
		return $false
	else
		dk_error "ERROR: no package managers found"
	fi
	return $false
}