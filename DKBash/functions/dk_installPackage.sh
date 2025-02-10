#!/usr/bin/env sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_installPackage(package)
#
#   https://en.wikipedia.org/wiki/List_of_software_package_management_systems
#   https://en.wikipedia.org/wiki/Package_manager
#   https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg
#
dk_installPackage() {
	dk_debugFunc 1
	
	dk_call dk_echo "dk_installGit()"
	#if dk_call dk_packageInstalled ${1}; then
	#	dk_call dk_warning "${1} already installed"
	#	return $(true);
	#fi
	
	(command -v ${1}) && return $(true)
	
	dk_call dk_info "dk_installPackage() installing ${1}. . ."
	
	if (command -v apk); then
		dk_run ${SUDO_EXE} apk add "${1}"					# Alpine Package Keeper (alpine linux)
		return
	elif (command -v apt-get); then
		dk_run ${SUDO_EXE} apt-get -y install "${1}"		# Apt-get (debian)
		return
	elif (command -v apt); then	
		dk_run ${SUDO_EXE} apt -y install "${1}"			# Apt (debian)
		return
	elif (command -v brew); then	
		dk_run ${SUDO_EXE} brew install "${1}"				# Homebrew (MacOS)
		return
	elif (command -v dnf); then
		dk_run ${SUDO_EXE} dnf install "${1}"				# Dnf (yum)
		return
	elif (command -v emerge); then	
		dk_run ${SUDO_EXE} emerge "${1}"					# Portage
		return
	elif (command -v nix-env); then	
		dk_run ${SUDO_EXE} nix-env -i "${1}"				# Nix
		return
	elif (command -v ohpm); then	
		dk_run ${SUDO_EXE} ohpm install "${1}"				# Ohpm
		return
	elif (command -v pkg); then
		dk_run ${SUDO_EXE} pkg install "${1}"				# Termux
		return
	elif (command -v pacman); then
		dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
		dk_run ${SUDO_EXE} pacman -S "${1}" --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR}	# Pacman
		return
	elif (command -v swupd); then
		dk_run ${SUDO_EXE} swupd bundle-add "${1}"			# Swupd
		return
	elif (command -v tce-load); then
		dk_run ${SUDO_EXE} tce-load -wil "${1}"     		# Tiny core linux
		return
	elif (command -v winget); then
		dk_run ${SUDO_EXE} winget install "${1}"			# WinGet
		return
	elif (command -v xbps-install); then
		dk_run ${SUDO_EXE} xbps-install "${1}"				# Xbps
		return
	elif (command -v zypper); then
		dk_run ${SUDO_EXE} zypper in "${1}"				# Zypper
		return
	else
		dk_call dk_error "ERROR: no package managers found"
	fi
	
	(command -v ${1}) || dk_fatal "${1}: command not found"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_installPackage wget
}
