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
############ dk_onError trap ############

###### SUDO_EXE ######
SUDO_EXE(){
	(command -v sudo) && export SUDO_EXE=$(command -v sudo) || echo "sudo-NOTFOUND" >&2
}

###### CMD_EXE ######
CMD_EXE(){
	(command -v cmd.exe) && export CMD_EXE=$(command -v cmd.exe) || echo "cmd.exe-NOTFOUND" >&2
}

###### CYGPATH_EXE ######
CYGPATH_EXE(){
	(command -v cygpath) && export CYGPATH_EXE=$(command -v cygpath) || echo "cygpath-NOTFOUND"  >&2
}

###### WSLPATH_EXE ######
WSLPATH_EXE(){
	(command -v wslpath) && export WSLPATH_EXE=$(command -v wslpath) || echo "wslpath-NOTFOUND"  >&2
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
	[ ! -e "${DKHOME_DIR-}" ] && [ -e "${HOME}" ] 		 	&& export DKHOME_DIR="${HOME}"
	[   -e "${DKHOME_DIR-}" ] && echo "${DKHOME_DIR-}"   	|| echo "DKHOME_DIR-NOTFOUND"  >&2
}

###### DKCACHE_DIR ######
DKCACHE_DIR(){
	[ ! -e "${DKCACHE_DIR-}" ] && export DKCACHE_DIR="$(DKHOME_DIR)/.dk"
	[ ! -e "${DKCACHE_DIR-}" ] && mkdir "${DKCACHE_DIR}"
	[   -e "${DKCACHE_DIR-}" ] && echo "${DKCACHE_DIR-}"   	|| echo "DKCACHE_DIR-NOTFOUND"  >&2
}

###### DIGITALKNOB_DIR ######
DIGITALKNOB_DIR(){
	[ ! -e "${DIGITALKNOB_DIR-}" ] && export DIGITALKNOB_DIR="$(DKHOME_DIR)/digitalknob"
	[ ! -e "${DIGITALKNOB_DIR-}" ] && mkdir "${DIGITALKNOB_DIR}"
	[   -e "${DIGITALKNOB_DIR-}" ] && echo "${DIGITALKNOB_DIR-}"   	|| echo "DIGITALKNOB_DIR-NOTFOUND"  >&2
}

###### DKBRANCH_DIR ######
DKBRANCH_DIR(){
	[ ! -e "${DKBRANCH_DIR-}" ] && export DKBRANCH_DIR="$(DIGITALKNOB_DIR)/Development"
	[ ! -e "${DKBRANCH_DIR-}" ] && mkdir "${DKBRANCH_DIR}"
	[   -e "${DKBRANCH_DIR-}" ] && echo "${DKBRANCH_DIR-}"   	|| echo "DKBRANCH_DIR-NOTFOUND"  >&2
}

###### DKBASH_DIR ######
DKBASH_DIR(){
	[ ! -e "${DKBASH_DIR-}" ] && export DKBASH_DIR="$(DKBRANCH_DIR)/DKBash"
	[ ! -e "${DKBASH_DIR-}" ] && mkdir "${DKBASH_DIR}"
	[   -e "${DKBASH_DIR-}" ] && echo "${DKBASH_DIR-}"   	|| echo "DKBASH_DIR-NOTFOUND"  >&2
}

###### DKBASH_FUNCTIONS_DIR ######
DKBASH_FUNCTIONS_DIR(){
	[ ! -e "${DKBASH_FUNCTIONS_DIR-}" ] && export DKBASH_FUNCTIONS_DIR="$(DKBASH_DIR)/functions"
	[ ! -e "${DKBASH_FUNCTIONS_DIR-}" ] && mkdir "${DKBASH_FUNCTIONS_DIR}"
	[   -e "${DKBASH_FUNCTIONS_DIR-}" ] && echo "${DKBASH_FUNCTIONS_DIR-}"   	|| echo "DKBASH_FUNCTIONS_DIR-NOTFOUND"  >&2
}

###### CHATTR_EXE ######
CHATTR_EXE(){
	(command -v chattr) && export CHATTR_EXE=$(command -v chattr) || echo "chattr-NOTFOUND"  >&2
}

###### WGET_EXE ######
WGET_EXE(){
	(command -v wget) && export WGET_EXE=$(command -v wget) || echo "wget-NOTFOUND"  >&2
}

###### CURL_EXE ######
CURL_EXE(){
	(command -v curl) && export CURL_EXE=$(command -v curl) || echo "curl-NOTFOUND"  >&2
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


[ "$(DKCACHE_DIR)/$(basename $0)" -ef "$0)" ] && [ -e "$(DKCACHE_DIR)" ] 	&& cp "$0" "$(DKCACHE_DIR)/$(basename $0)"
[ -e "$(DKCACHE_DIR)/DKBash" ] 	&& export > "$(DKCACHE_DIR)/default_env.sh"


export DK="$(DKBASH_FUNCTIONS_DIR)/DK.sh"
export HDK="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions/DK.sh"
[ ! -e "${DK}" ] && [ -e "$(CURL_EXE)" ] && $(CURL_EXE) -Lo "${DK}" "${HDK}"
[ ! -e "${DK}" ] && [ -e "$(WGET_EXE)" ] && $(WGET_EXE) -P "${DK}" "${HDK}"
#[ ! -e "${DK}" ] && [ -e "$(CURL_EXE)" ] && dk_call dk_firewallAllow "CURL" "$(CURL_EXE)" && $(CURL_EXE) -Lo "${DK}" "${HDK}"
[ ! -e "${DK}" ] && echo "DK:${DK} does not exist" && exit 1

$(SUDO_EXE) chmod 777 "${DK}"
. "${DK}" # $0 $*



#####################
dk_call dk_buildMain
