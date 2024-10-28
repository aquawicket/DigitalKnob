#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

SUDO_EXE(){
	(command -v sudo) || echo "sudo Not Found" >&2
}

##################################################################################
# dk_wslFixNet(message)
#
#    https://github.com/microsoft/WSL/issues/5420#issuecomment-646479747
#
dk_wslFixNet() {
	dk_debugFunc 0
	
	[ -e "/etc/resolv.conf" ] && $(SUDO_EXE) rm "/etc/resolv.conf"
	$(SUDO_EXE) sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
	$(SUDO_EXE) sh -c 'echo "[network]" > /etc/wsl.conf'
	$(SUDO_EXE) sh -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
	$(SUDO_EXE) chattr +i /etc/resolv.conf
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_wslFixNet
}
