#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_installPackage(package)
#
#   https://en.wikipedia.org/wiki/List_of_software_package_management_systems
#   https://en.wikipedia.org/wiki/Package_manager
#   https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg
#
dk_installPackage() {
	dk_debugFunc 1
	
	#if dk_call dk_packageInstalled ${1}; then
	#	dk_call dk_warning "${1} already installed"
	#	return $(true);
	#fi
	
	(command -v ${1}) && return $(true)
	
	dk_call dk_info "installing ${1}. . ."
	if (command -v apk); then
		apk add "${1}"					# Alpine Package Keeper (alpine linux)
		return
	elif (command -v apt-get); then
		apt-get -y install "${1}"		# Apt-get (debian)
		return
	elif (command -v apt); then	
		apt -y install "${1}"			# Apt (debian)
		return
	elif (command -v brew); then	
		brew install "${1}"				# Homebrew (MacOS)
		return
	elif (command -v dnf); then
		dnf install "${1}"				# Dnf (yum)
		return
	elif (command -v emerge); then	
		emerge "${1}"					# Portage
		return
	elif (command -v nix-env); then	
		nix-env -i "${1}"				# Nix
		return
	elif (command -v ohpm); then	
		ohpm install "${1}"				# Ohpm
		return
	elif (command -v pkg); then
		pkg install "${1}"				# Termux
		return
	elif (command -v pacman); then
		dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DIGITALKNOB_DIR"
		pacman -S "${1}" --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR}	# Pacman
		return
	elif (command -v swupd); then
		swupd bundle-add "${1}"			# Swupd
		return
	elif (command -v tce-load); then
		tce-load -wil "${1}"     		# Tiny core linux
		return
	elif (command -v winget); then
		winget install "${1}"			# WinGet
		return
	elif (command -v xbps-install); then
		xbps-install "${1}"				# Xbps
		return
	elif (command -v zypper); then
		zypper in "${1}"				# Zypper
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
