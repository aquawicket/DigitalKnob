#!/bin/sh
############ dk_onError trap ############
(set -o posix)			&& set -o posix			|| echo "(set -o posix) failed"
(set -o pipefail) 		&& set -o pipefail  	|| echo "(set -o pipefail) failed"  	# trace ERR through pipes
(set -E) 				&& set -E  				|| echo "(set -E) failed" 				# set -E : trace ERR through 'time command' and other functions
(set -u) 		 		&& set -u			   	|| echo "(set -u) failed" 				# set -u : exit the script if you try to use an uninitialised variable
(set -e)  	 			&& set -e  				|| echo "(set -e) failed" 				# set -e : exit the script if any statement returns a non-true
(shopt -s extdebug)     && shopt -s extdebug	|| echo "(shopt -s extdebug) failed" 

#trap 'echo "Press Enter to continue..."; read' SIGUSR1
#alias _pause='kill -s USR1 $$'
(trap dk_onError ERR &>/dev/null)  && trap dk_onError ERR  || echo "(trap dk_onError ERR) failed"
dk_onError(){
	exitcode=$?
	
	echo "" &>/dev/tty
	if [ -n "${1-}" ];then
		echo "ERROR: '${1-}'" &>/dev/tty
	else
		echo "ERROR: '${BASH_COMMAND-}'" &>/dev/tty
	fi
	echo "file: ${BASH_SOURCE[0]}" &>/dev/tty
	echo "line: ${BASH_LINENO[0]}" &>/dev/tty
	echo "exit_code: ${exitcode}" &>/dev/tty
	echo "" &>/dev/tty

	#_pause
	read -rp 'Press Enter to continue...'
	exit ${exitcode}
}
#########################################
	

###### SUDO_EXE ######
SUDO_EXE(){
	[ -e "${SUDO_EXE-}" ]	|| export SUDO_EXE=$(command -v sudo) || true
	[ -e "${SUDO_EXE-}" ]	&& echo "${SUDO_EXE}" || unset SUDO_EXE
	echo "SUDO_EXE = '${SUDO_EXE-}'" &>/dev/tty
}

###### CMD_EXE ######
CMD_EXE(){
	[ -e "${CMD_EXE-}" ]	|| export CMD_EXE=$(command -v cmd.exe) || true
	[ -e "${CMD_EXE-}" ]	|| export CMD_EXE="/mnt/c/Windows/System32/cmd.exe"
	[ -e "${CMD_EXE-}" ]	&& echo "${CMD_EXE-}" || dk_onError "CMD_EXE:${CMD_EXE-} Not Found"
	echo "CMD_EXE = '${CMD_EXE-}'" &>/dev/tty
}

###### CYGPATH_EXE ######
CYGPATH_EXE(){
	[ -e "${CYGPATH_EXE-}" ] || export CYGPATH_EXE=$(command -v cygpath) || true
	[ -e "${CYGPATH_EXE-}" ] && echo "${CYGPATH_EXE}" || unset CYGPATH_EXE
	echo "CYGPATH_EXE = '${CYGPATH_EXE-}'" &>/dev/tty
}

###### WSLPATH_EXE ######
WSLPATH_EXE(){
	[ -e "${WSLPATH_EXE-}" ] || export WSLPATH_EXE=$(command -v wslpath) || true
	[ -e "${WSLPATH_EXE-}" ] && echo "${WSLPATH_EXE}" || unset WSLPATH_EXE
	echo "WSLPATH_EXE = '${WSLPATH_EXE-}'" &>/dev/tty
}

###### DKHOME_DIR ######
DKHOME_DIR(){
	[ ! -e "${DKHOME_DIR-}" ] && [ -e "$(WSLPATH_EXE)" ] && export DKHOME_DIR=$($(WSLPATH_EXE) -u $($(CMD_EXE) /c echo "%USERPROFILE%" | tr -d '\r'))
	[ ! -e "${DKHOME_DIR-}" ] && [ -e "$(CYGPATH_EXE)" ] && export DKHOME_DIR=$($(CYGPATH_EXE) -u $($(CMD_EXE) "/c echo %USERPROFILE% | tr -d '\r'"))
	[ ! -e "${DKHOME_DIR-}" ] && [ -e "${HOME}" ] 		 && export DKHOME_DIR=${HOME}
	[ -e "${DKHOME_DIR-}" ]	  && echo "${DKHOME_DIR-}"   || dk_onError "DKHOME_DIR:${DKHOME_DIR-} Not Found"
	echo "DKHOME_DIR = '${DKHOME_DIR-}'" &>/dev/tty
}

###### Net fix for WSL ######
if [ -e "$(WSLPATH_EXE)" ]; then	
	[ -e "/etc/resolv.conf" ] && $(SUDO_EXE) rm /etc/resolv.conf
	$(SUDO_EXE) sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
	$(SUDO_EXE) sh -c 'echo "[network]" > /etc/wsl.conf'
	$(SUDO_EXE) sh -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
	(command -v chattr &>/dev/null) && $(SUDO_EXE) chattr +i /etc/resolv.conf
fi



export DKF="$(DKHOME_DIR)/digitalknob/Development/DKBash/functions"
[ -e "${DKF}" ] 					|| export DKF="${DKHOME_DIR}/.dk/DKBash/functions"
[ -e "$(DKHOME_DIR)/.dk" ] 			|| mkdir "$(DKHOME_DIR)/.dk"
[ -e "$(DKHOME_DIR)/.dk/DKBash" ] 	|| mkdir "$(DKHOME_DIR)/.dk/DKBash"
[ -e "${DKF}" ] 					|| mkdir "${DKF}"
[ -e "${DKF}" ] 					|| echo "DKF:${DKF} does not exist" || exit 1

export DK="${DKF}/DK.sh"
export HDK="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions/DK.sh"
[ ! -e "${DK}" ] && (command -v wget &>/dev/null) && wget -P "${DKF}" "${HDK}"
[ ! -e "${DK}" ] && (command -v curl &>/dev/null) && curl -Lo "${DK}" "${HDK}"
[ ! -e "${DK}" ] && echo "DK:${DK} does not exist" && exit 1

$(SUDO_EXE) chmod 777 "${DK}"
. "${DK}"
#"${DK}" $0 $*

#####################
dk_call dk_buildMain
