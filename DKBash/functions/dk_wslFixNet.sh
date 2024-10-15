#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

##################################################################################
# dk_warning(message)
#
#	Print a warning message to the console
#
#	@msg	- The message to print
#
dk_wslFixNet() {
	dk_debugFunc 0
	
	${SUDO_EXE} rm /etc/resolv.conf
	${SUDO_EXE} sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
	${SUDO_EXE} sh -c 'echo "[network]" > /etc/wsl.conf'
	${SUDO_EXE} sh -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
	${SUDO_EXE} chattr +i /etc/resolv.conf
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_wslFixNet
}
