#!/bin/sh


############ dk_onError trap ############
(set -o posix 		 2>/dev/null)	&& set -o posix			|| echo "'set -o posix' failed"
(set -o pipefail 	 2>/dev/null)	&& set -o pipefail  	|| echo "'set -o pipefail' failed"  	# trace ERR through pipes
(set -E				 2>/dev/null)	&& set -E  				|| echo "'set -E' failed" 				# set -E : trace ERR through 'time command' and other functions
(set -u				 2>/dev/null)	&& set -u			   	|| echo "'set -u' failed" 				# set -u : exit the script if you try to use an uninitialised variable
(set -e				 2>/dev/null)	&& set -e  				|| echo "'set -e' failed" 				# set -e : exit the script if any statement returns a non-true
(shopt -s extdebug	 2>/dev/null)	&& shopt -s extdebug	|| echo "'shopt -s extdebug' failed" 
(trap dk_onError ERR 2>/dev/null)   && trap dk_onError ERR  || echo "'trap dk_onError ERR' failed"

dk_onError(){
	exitcode=$?	
	echo "" >&2
	if [ -n "${1-}" ];then
		echo "ERROR: '${1-}'" >&2
	else
		echo "ERROR: '${BASH_COMMAND-}'" >&2
	fi
	[ -n "${BASH_SOURCE-}" ] && echo "file: $BASH_SOURCE" >&2 || echo "file: $0" >&2
	[ -n "${BASH_LINENO-}" ] && echo "line: $BASH_LINENO" >&2 || echo "line: ${LINENO-}" >&2
	echo "exit_code: ${exitcode}" >&2
	echo "" >&2
	read -rp 'Press Enter to continue...'
	exit ${exitcode}
}
#########################################

###### SUDO_EXE ######
SUDO_EXE(){
	(command -v sudo) && export SUDO_EXE=$(command -v sudo) || echo "sudo Not Found" >&2
}

###### CMD_EXE ######
CMD_EXE(){
	(command -v cmd.exe) && export CMD_EXE=$(command -v cmd.exe) || echo "cmd.exe Not Found" >&2
}

###### CYGPATH_EXE ######
CYGPATH_EXE(){
	(command -v cygpath) && export CYGPATH_EXE=$(command -v cygpath) || echo "cygpath Not Found"  >&2
}

###### WSLPATH_EXE ######
WSLPATH_EXE(){
	(command -v wslpath) && export WSLPATH_EXE=$(command -v wslpath) || echo "wslpath Not Found"  >&2
}

###### WSLPATH_EXE ######
ANDROID_SDCARD(){
	(grep -o "/storage/....-...." /proc/mounts) && export ANDROID_SDCARD=$(grep -o "/storage/....-...." /proc/mounts) || echo "ANDROID_SDCARD() failed"  >&2
}

###### DKHOME_DIR ######
DKHOME_DIR(){
	[ ! -e "${DKHOME_DIR-}" ] && [ -e "$(WSLPATH_EXE)" ] 	&& export DKHOME_DIR=$($(WSLPATH_EXE) -u $($(CMD_EXE) /c echo "%USERPROFILE%" | tr -d '\r')) 	# Windows subsystem for linux
	[ ! -e "${DKHOME_DIR-}" ] && [ -e "$(CYGPATH_EXE)" ] 	&& export DKHOME_DIR=$($(CYGPATH_EXE) -u $($(CMD_EXE) "/c echo %USERPROFILE% | tr -d '\r'")) 	# Git for windows
#	[ ! -e "${DKHOME_DIR-}" ] && [ -e "$(ANDROID_SDCARD)" ] && export DKHOME_DIR=$(ANDROID_SDCARD) 															# Android sdcard
	[ ! -e "${DKHOME_DIR-}" ] && [ -e "${HOME}" ] 		 	&& export DKHOME_DIR=${HOME}
	[   -e "${DKHOME_DIR-}" ] && echo "${DKHOME_DIR-}"   	|| echo "DKHOME_DIR Not Found"  >&2
}

###### CHATTR_EXE ######
CHATTR_EXE(){
	(command -v chattr) && export CHATTR_EXE=$(command -v chattr) || echo "chattr Not Found"  >&2
}

###### WGET_EXE ######
WGET_EXE(){
	(command -v wget) && export WGET_EXE=$(command -v wget) || echo "wget Not Found"  >&2
}

###### CURL_EXE ######
CURL_EXE(){
	(command -v curl) && export CURL_EXE=$(command -v curl) || echo "curl Not Found"  >&2
}

###### Net fix for WSL ######
#dk_wslFixNet(){
#	[ ! -e "$(WSLPATH_EXE)" ] && return
#		
#	echo "Applying WSL internet fix"
#	#[ -e "/etc/resolv.conf" ] && $(SUDO_EXE) rm -f /etc/resolv.conf
#	($(SUDO_EXE) sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf') && $(SUDO_EXE) sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
#	$(SUDO_EXE) sh -c 'echo "[network]" > /etc/wsl.conf'
#	$(SUDO_EXE) sh -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
#	#$(SUDO_EXE) chattr +i /etc/resolv.conf
#}

###	Fix WSL retaining file permissions 
### https://superuser.com/a/1392722/600216
#dk_wslFixFileAccess(){
#	[ ! -e "$(WSLPATH_EXE)" ] && return
#	
#	[ ! -e "/etc" ] && echo "ERROR: /etc directory does not exist"
#	[   -e "/etc/wsl.conf" ] && echo "/etc/wsl.conf already exists" && return
#	
#	$(SUDO_EXE) sh -c 'echo "" 										 	 > "/etc/wsl.conf"'
#	$(SUDO_EXE) sh -c 'echo "[boot]" 									>> "/etc/wsl.conf"'
#	$(SUDO_EXE) sh -c 'echo "systemd=true"								>> "/etc/wsl.conf"'
#	$(SUDO_EXE) sh -c 'echo ""											>> "/etc/wsl.conf"'
#	$(SUDO_EXE) sh -c 'echo "[automount]"								>> "/etc/wsl.conf"'
#	$(SUDO_EXE) sh -c 'echo "enabled = true"							>> "/etc/wsl.conf"'
#	$(SUDO_EXE) sh -c 'echo "root = /mnt/"								>> "/etc/wsl.conf"'
#	$(SUDO_EXE) sh -c 'echo "options = \"metadata,umask=22,fmask=11\"" 	>> "/etc/wsl.conf"'
#	$(SUDO_EXE) sh -c 'echo ""											>> "/etc/wsl.conf"'
#	$(SUDO_EXE) sh -c 'echo "[network]" 								>> "/etc/wsl.conf"'
#	$(SUDO_EXE) sh -c 'echo "generateResolvConf = false" 				>> "/etc/wsl.conf"'
#}

export DKF="$(DKHOME_DIR)/digitalknob/Development/DKBash/functions"
[ -e "${DKF}" ] 					|| export DKF="$(DKHOME_DIR)/.dk/DKBash/functions"
[ -e "$(DKHOME_DIR)/.dk" ] 			|| mkdir "$(DKHOME_DIR)/.dk"
[ "$(DKHOME_DIR)/.dk/$(basename $0)" -ef "$0)" ] && [ -e "$(DKHOME_DIR)/.dk" ] 	&& cp "$0" "$(DKHOME_DIR)/.dk/$(basename $0)"
[ -e "$(DKHOME_DIR)/.dk/DKBash" ] 	|| mkdir "$(DKHOME_DIR)/.dk/DKBash"
[ -e "$(DKHOME_DIR)/.dk/DKBash" ] 	&& export > "$(DKHOME_DIR)/.dk/DKBash/default_env.sh"
[ -e "${DKF}" ] 					|| mkdir "${DKF}"
[ -e "${DKF}" ] 					|| echo "DKF:${DKF} does not exist" || exit 1

export DK="${DKF}/DK.sh"
export HDK="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions/DK.sh"
[ ! -e "${DK}" ] && [ -e "$(WGET_EXE)" ] && $(WGET_EXE) -P "${DKF}" "${HDK}"
[ ! -e "${DK}" ] && [ -e "$(CURL_EXE)" ] && dk_call dk_firewallAllow "CURL" $(CURL_EXE) && $(CURL_EXE) -Lo "${DK}" "${HDK}"
[ ! -e "${DK}" ] && echo "DK:${DK} does not exist" && exit 1

$(SUDO_EXE) chmod 777 "${DK}"
. "${DK}" # $0 $*



#####################
dk_call dk_buildMain
