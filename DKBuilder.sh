#!/bin/sh
###### DKBuilder ######
[ -n "$(command -v "sudo")" ] && export SUDO_EXE="sudo" || export SUDO_EXE=" "

###### DKINIT ######
export DKSCRIPT_PATH="$0"
echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"

export DKHTTP_DKBASH_FUNCTIONS_DIR="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions"
echo "DKHTTP_DKBASH_FUNCTIONS_DIR = ${DKHTTP_DKBASH_FUNCTIONS_DIR}"

export DKBASH_DIR="${PWD}/DKBash"
echo "DKBASH_DIR = ${DKBASH_DIR}"

export DKBASH_FUNCTIONS_DIR="${DKBASH_DIR}/functions"
echo "DKBASH_FUNCTIONS_DIR = ${DKBASH_FUNCTIONS_DIR}"

[ -e "${DKBASH_DIR}" ] || ${SUDO_EXE} mkdir "${DKBASH_DIR}"
export DKUSERNAME="${USER-}"
[ -n "${DKUSERNAME-}" ] || export DKUSERNAME="${USERNAME-}"
[ -n "${DKUSERNAME-}" ] || echo "ERROR: unable to set DKUSERNAME"
echo "DKUSERNAME = ${DKUSERNAME}"

[ -n "${DKUSERNAME-}" ] && [ -e "${DKBASH_DIR}" ] && ${SUDO_EXE-} chown -R ${DKUSERNAME} ${DKBASH_DIR}
#TAKEOWN /F ${DKBATCH_DIR} /R /D "Y"

[ -e "${DKBASH_FUNCTIONS_DIR}" ] || mkdir ${DKBASH_FUNCTIONS_DIR}

if [ ! -e ${DKBASH_FUNCTIONS_DIR}/DK.sh ]; then
	# https://en.wikipedia.org/wiki/Package_manager
	if [ -z "$(command -v "wget")" ] && [ -z "$(command -v "curl")" ]; then
		[ -n "$(command -v "apk")" ]           		&& alias dk_installPackage='apk add'  	 		# Alpine Package Keeper (alpine linux)
		[ -n "$(command -v "apt-get")" ]       		&& alias dk_installPackage='apt-get -y install'	# Apt-get (debian)
		[ -n "$(command -v "apt")" ]           		&& alias dk_installPackage='apt -y install'		# Apt (debian)
		[ -n "$(command -v "brew")" ]          		&& alias dk_installPackage='brew install'		# Homebrew (MacOS)
		[ -n "$(command -v "dnf")" ]           		&& alias dk_installPackage='dnf install'		# Dnf (yum)
		[ -n "$(command -v "emerge")" ]        		&& alias dk_installPackage='emerge'				# Portage
		[ -n "$(command -v "nix-env")" ]       		&& alias dk_installPackage='nix-env -i'			# Nix
		[ -n "$(command -v "ohpm")" ]          		&& alias dk_installPackage='ohpm install'		# Ohpm
		[ -n "$(command -v "pkg")" ]           		&& alias dk_installPackage='pkg install'		# Termux
		[ -n "$(command -v "pacman")" ]        		&& alias dk_installPackage='pacman -S'			# Pacman
		[ -n "$(command -v "swupd")" ]         		&& alias dk_installPackage='swupd bundle-add'	# Swupd
		[ -n "$(command -v "tce-load")" ]      		&& alias dk_installPackage='tce-load -wil'     	# Tiny core linux
		[ -n "$(command -v "winget")" ]        		&& alias dk_installPackage='winget install'		# WinGet
		[ -n "$(command -v "xbps-install")" ]		&& alias dk_installPackage='xbps-install'		# Xbps
		[ -n "$(command -v "zypper")" ]        		&& alias dk_installPackage='zypper in'			# Zypper
		[ -z "$(command -v "dk_installPackage")" ]  && echo "ERROR: Unable to aquire DK.sh, no package managers found. Please install wget or curl." && read -rp "Press enter to exit..." && exit 1
		[ -z "$(command -v "wget")" ] && [ -z "$(command -v "curl")" ] && dk_installPackage wget
		[ -z "$(command -v "wget")" ] && [ -z "$(command -v "curl")" ] && dk_installPackage curl
		[ -z "$(command -v "wget")" ] && [ -z "$(command -v "curl")" ] && echo "ERROR: Unable to aquire DK.sh, no download apps found. Please install wget or curl." && read -rp "Press enter to exit..." && exit 1
	fi
	[ ! -e ${DKBASH_FUNCTIONS_DIR}/DK.sh ] && [ -n "$(command -v "wget")" ] && wget -P "${DKBASH_FUNCTIONS_DIR}" "${DKHTTP_DKBASH_FUNCTIONS_DIR}/DK.sh"
	[ ! -e ${DKBASH_FUNCTIONS_DIR}/DK.sh ] && [ -n "$(command -v "curl")" ] && curl -Lo "${DKBASH_FUNCTIONS_DIR}/DK.sh" "${DKHTTP_DKBASH_FUNCTIONS_DIR}/DK.sh"
	[ ! -e ${DKBASH_FUNCTIONS_DIR}/DK.sh ] && echo "ERROR: Unable to aquire DK.sh, please git clone the repository https://github.com/aquawicket/DigitalKnob.git" && read -rp "Press enter to exit..." && exit 1
	chmod 777 ${DKBASH_FUNCTIONS_DIR}/DK.sh
fi
. ${DKBASH_FUNCTIONS_DIR}/DK.sh


###### Load Main Program ######
[ -z "$(command -v "dk_buildMain")" ] && [ $# -gt 0 ] && "$@" || dk_call dk_buildMain
