# dk_include_guard()

##################################################################################
# dk_package_installed(<package>)
#
#
dk_package_installed () {
	dk_verbose "dk_package_installed($*)"
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"

	if dk_commandExists dpkg-query; then
		if [ $(dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -c "ok dk_installed") -ne 0 ]; then
			return $true
		fi
	elif dk_commandExists brew; then
		if brew list "$1" &>/dev/null; then
			return $true
		fi
	elif dk_commandExists apt; then
		dk_error "dk_package_installed() apt-get not implemented"
	elif dk_commandExists apt-get; then
		dk_error "dk_package_installed() apt-get not implemented"
	elif dk_commandExists pkg; then
		dk_error "dk_package_installed() pkg not implemented"
	elif dk_commandExists pacman; then
		if pacman -Qs "$1" > /dev/null; then
			#FIXME: this doesn't always work
			return $false;
		fi
	elif dk_commandExists tce-load; then
		#dk_error "dk_package_installed() tce-load not implemented"
		return $false
	else
		dk_error "ERROR: no package managers found"
	fi
	return $false
}