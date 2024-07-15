#!/bin/sh
###### DKBuilder ######
[ -n "$(command -v "sudo")" ] && export dksudo="sudo" || export dksudo=" "

###### DKINIT ######
export DKHTTP_DKBASH_FUNCTIONS_DIR="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions"
export DKBASH_DIR="$PWD/DKBash"
export DKBASH_FUNCTIONS_DIR="${DKBASH_DIR}/functions"
[ -e ${DKBASH_DIR} ] || ${dksudo} mkdir ${DKBASH_DIR}
${dksudo} chown -R ${USERNAME} ${DKBASH_DIR}
#${dksudo} chmod 777 ${DKBASH_DIR}

[ -e ${DKBASH_FUNCTIONS_DIR} ] || mkdir ${DKBASH_FUNCTIONS_DIR}
#${dksudo} chmod 777 ${DKBASH_FUNCTIONS_DIR}

if [ ! -e ${DKBASH_FUNCTIONS_DIR}/DK.sh ]; then
	# https://en.wikipedia.org/wiki/Package_manager
	if [ -z "$(command -v "wget")" ] && [ -z "$(command -v "curl")" ]; then
		[ -n "$(command -v "apk")" ]           && alias dk_install='${dksudo} apk add'  	 		# Alpine Package Keeper (alpine linux)
		[ -n "$(command -v "apt-get")" ]       && alias dk_install='${dksudo} apt-get -y install'	# Apt-get (debian)
		[ -n "$(command -v "apt")" ]           && alias dk_install='${dksudo} apt -y install'		# Apt (debian)
		[ -n "$(command -v "brew")" ]          && alias dk_install='${dksudo} brew install'			# Homebrew (MacOS)
		[ -n "$(command -v "dnf")" ]           && alias dk_install='${dksudo} dnf install'			# Dnf (yum)
		[ -n "$(command -v "emerge")" ]        && alias dk_install='${dksudo} emerge'				# Portage
		[ -n "$(command -v "nix-env")" ]       && alias dk_install='${dksudo} nix-env -i'			# Nix
		[ -n "$(command -v "ohpm")" ]          && alias dk_install='${dksudo} ohpm install'			# Ohpm
		[ -n "$(command -v "pkg")" ]           && alias dk_install='${dksudo} pkg install'			# Termux
		[ -n "$(command -v "pacman")" ]        && alias dk_install='${dksudo} pacman -S'			# Pacman
		[ -n "$(command -v "swupd")" ]         && alias dk_install='${dksudo} swupd bundle-add'		# Swupd
		[ -n "$(command -v "tce-load")" ]      && alias dk_install='${dksudo} tce-load -wil'     	# Tiny core linux
		[ -n "$(command -v "winget")" ]        && alias dk_install='${dksudo} winget install'		# WinGet
		[ -n "$(command -v "xbps-install")" ]  && alias dk_install='${dksudo} xbps-install'			# Xbps
		[ -n "$(command -v "zypper")" ]        && alias dk_install='${dksudo} zypper in'			# Zypper
		[ -z "$(command -v "dk_install")" ]    && echo "ERROR: Unable to aquire DK.sh, no package managers found. Please install wget or curl." && read -rp "Press enter to exit..." && exit 1
		[ -z "$(command -v "wget")" ] && [ -z "$(command -v "curl")" ] && ${dksudo} dk_install wget
		[ -z "$(command -v "wget")" ] && [ -z "$(command -v "curl")" ] && ${dksudo} dk_install curl
		[ -z "$(command -v "wget")" ] && [ -z "$(command -v "curl")" ] && echo "ERROR: Unable to aquire DK.sh, no download apps found. Please install wget or curl." && read -rp "Press enter to exit..." && exit 1
	fi
	[ ! -e ${DKBASH_FUNCTIONS_DIR}/DK.sh ] && [ -n "$(command -v "wget")" ] && wget -P "${DKBASH_FUNCTIONS_DIR}" "${DKHTTP_DKBASH_FUNCTIONS_DIR}/DK.sh"
	[ ! -e ${DKBASH_FUNCTIONS_DIR}/DK.sh ] && [ -n "$(command -v "curl")" ] && curl -Lo "${DKBASH_FUNCTIONS_DIR}/DK.sh" "${DKHTTP_DKBASH_FUNCTIONS_DIR}/DK.sh"
	[ ! -e ${DKBASH_FUNCTIONS_DIR}/DK.sh ] && echo "ERROR: Unable to aquire DK.sh, please git clone the repository https://github.com/aquawicket/DigitalKnob.git" && read -rp "Press enter to exit..." && exit 1
	chmod 777 ${DKBASH_FUNCTIONS_DIR}/DK.sh
fi
. ${DKBASH_FUNCTIONS_DIR}/DK.sh


###### Load Main Program ######
[ -z "$(command -v "dk_buildMain")" ] && [ $# -gt 0 ] && "$@" || dk_buildMain
