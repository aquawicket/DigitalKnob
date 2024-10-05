#!/bin/sh
echo "DKBuilder.sh()"

### SUDO_EXE ###
[ -n "$(command -v "sudo")" ] && export SUDO_EXE="sudo" || export SUDO_EXE=" "

### DKSCRIPT_PATH ###
$(command -v realpath 1>/dev/null) && export DKSCRIPT_PATH="$(realpath ${0})"

HDK="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions/DK.sh"

### SHELL Environment variables ###
#	DKOS	    DKHOST		DKSHELL		DKHOME								<ENV>							
#	Android		Termux 		bash		/data/data/com.termux/files/home	${HOME}									
#	Windows		11			Cmd			C:\Users\<username>					%USERPROFILE%
#	Windows 	Git 		bash		/c/Users/<username>					cygpath $USERPROFILE,   ${HOME}
#	Windows		Msys2		bash		/c/Users/<username>					cygpath $USERPROFILE
#	Windows		Wsl 		bash		/mnt/c/Users/<username>				wslpath /mnt/c/Windows/System32/cmd.exe /c "echo %USERPROFILE%"
#	Linux		Lxle 		bash		/home/<username>					${HOME}
#	Mac			Osx			bash		/home/<username>					${HOME}
#	Raspberry	Pi OS		bash		/home/<username>					${HOME}
#

[ ! -e "${DRIVE}" ]			&& export DRIVE="/c"
[ ! -e "${DRIVE}" ]			&& export DRIVE="/mnt/c"
[ ! -e "${CMD_EXE}" ]		&& export CMD_EXE=$(command -v cmd.exe)
[ ! -e "${CMD_EXE}" ]		&& export CMD_EXE="${DRIVE}/Windows/System32/cmd.exe"
[ ! -e "${CYGPATH_EXE}" ]	&& export CYGPATH_EXE=$(command -v "cygpath")
[   -e "${CYGPATH_EXE}" ]	&& export USERPROFILE=$(${CYGPATH_EXE} -u $(${CMD_EXE} "/c echo %USERPROFILE% | tr -d '\r'"))
[ ! -e "${WSLPATH_EXE}" ]	&& export WSLPATH_EXE=$(command -v "wslpath")
[   -e "${WSLPATH_EXE}" ]	&& export USERPROFILE=$(${WSLPATH_EXE} -u $(${CMD_EXE} /c echo "%USERPROFILE%" | tr -d '\r'))
[ ! -e "${DKHOME_DIR}" ]	&& export DKHOME_DIR=${USERPROFILE}
[ ! -e "${DKHOME_DIR}" ]	&& export DKHOME_DIR=${HOME}
[ ! -e "${DKHOME_DIR}" ]	&& export DKHOME_DIR=${PWD}	
[ ! -e "${DKHOME_DIR}" ] 	&& echo "ERROR: DKHOME_DIR:${DKHOE_DIR} not found" && exit 13
[ ! -e "${DKCACHE_DIR}" ]	&& export DKCACHE_DIR="${DKHOME_DIR}/.dk"
[ ! -e "${DKCACHE_DIR}" ]	&& mkdir "${DKCACHE_DIR}"
[ ! -e "${DKCACHE_DIR}" ]	&& echo "ERROR: DKCACHE_DIR:${DKCACHE_DIR} not found" && exit 13
[   -n "${DKUSERNAME-}" ]	|| export DKUSERNAME="${USER-}"
[   -n "${DKUSERNAME-}" ]	|| export DKUSERNAME="${USERNAME-}"
[   -n "${DKUSERNAME-}" ]	|| echo "ERROR: unable to set DKUSERNAME"


export DKF="${DKHOME_DIR}/digitalknob/Development/DKBash/functions"
[ ! -e "${DKF}" ] && export DKF="${DKCACHE_DIR}/DKBash/functions"
export DKBASH_DIR="$(dirname ${DKF})"
[ ! -e "${DKBASH_DIR}" ] && mkdir "${DKBASH_DIR}"
[ ! -e "${DKF}" ] && mkdir "${DKF}"
[ -n "${DKUSERNAME-}" ] && [ -e "${DKBASH_DIR}" ] && ${SUDO_EXE-} chown -R ${DKUSERNAME} ${DKBASH_DIR}
DK="${DKF}/DK.sh"
[ ! -e "${DK}" ] && [ -n "$(command -v "wget")" ] && wget -P "${DKF}" "${HDK}"
[ ! -e "${DK}" ] && [ -n "$(command -v "curl")" ] && curl -Lo "${DK}" "${HDK}"
chmod 777 ${DK}
. ${DK}
[ -z "$(command -v "dk_buildMain")" ] && [ $# -gt 0 ] && "$@" || dk_call dk_buildMain
exit $?


if [ ! -e ${DK} ]; then
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
	[ ! -e ${DK} ] && [ -n "$(command -v "wget")" ] && wget -P "${DKF}" "${HDK}"
	[ ! -e ${DK} ] && [ -n "$(command -v "curl")" ] && curl -Lo "${DK}" "${HDK}"
	[ ! -e ${DK} ] && echo "ERROR: Unable to aquire DK.sh, please git clone the repository https://github.com/aquawicket/DigitalKnob.git" && read -rp "Press enter to exit..." && exit 1
	chmod 777 ${DK}
fi
. ${DK}


###### Load Main Program ######
[ -z "$(command -v "dk_buildMain")" ] && [ $# -gt 0 ] && "$@" || dk_call dk_buildMain
