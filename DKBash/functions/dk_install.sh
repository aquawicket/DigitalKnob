#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_install(package)
#
#
dk_install (){
	dk_debugFunc
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"

	[ -n "$(command -v "${1}")" ] && return    # 
	#if dk_packageInstalled ${1}; then
	#	dk_warning "${1} already dk_installed"
	#	return ${false};
	#fi
	
	dk_info "dk_installing ${1}"
	# https://en.wikipedia.org/wiki/List_of_software_package_management_systems
	# https://en.wikipedia.org/wiki/Package_manager
	# https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg
	
	if dk_commandExists apk; then
		dk_call apk add "${1}"					# Alpine Package Keeper (alpine linux)
	elif dk_commandExists apt-get; then
		dk_call apt-get -y install "${1}"			# Apt-get (debian)
	elif dk_commandExists apt; then	
		dk_call apt -y install "${1}"				# Apt (debian)
	elif dk_commandExists brew; then	
		dk_call brew install "${1}"				# Homebrew (MacOS)
	elif dk_commandExists dnf; then
		dk_call dnf install "${1}"				# Dnf (yum)
	elif dk_commandExists emerge; then	
		dk_call emerge "${1}"						# Portage
	elif dk_commandExists nix-env; then	
		dk_call nix-env -i "${1}"					# Nix
	elif dk_commandExists ohpm; then	
		dk_call ohpm install "${1}"				# Ohpm
	elif dk_commandExists pkg; then
		dk_call pkg install "${1}"				# Termux
	elif dk_commandExists pacman; then
		dk_call pacman -S "${1}" --noconfirm		# Pacman
	elif dk_commandExists swupd; then
		dk_call swupd bundle-add "${1}"			# Swupd
	elif dk_commandExists tce-load; then
		dk_call tce-load -wil "${1}"     			# Tiny core linux
	elif dk_commandExists winget; then
		dk_call winget install "${1}"				# WinGet
	elif dk_commandExists xbps-install; then
		dk_call xbps-install "${1}"				# Xbps
	elif dk_commandExists zypper; then
		dk_call zypper in "${1}"					# Zypper
	else
		dk_error "ERROR: no package managers found"
	fi
}




DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_install wget
}