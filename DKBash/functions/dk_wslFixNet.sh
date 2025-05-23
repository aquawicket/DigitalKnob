#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_wslFixNet(message)
#
#    https://github.com/microsoft/WSL/issues/5420#issuecomment-646479747
#
dk_wslFixNet() {
	dk_debugFunc 0
	echo "dk_wslFixNet.sh()"
	
	#[ ! -n "${WSLPATH_EXE-}" ] && return
	
	echo "Applying WSL internet fix"
	#[ ! -e "/etc" ] && echo "ERROR: /etc directory does not exist"
	#[   -e "/etc/resolv.conf" ] && echo "/etc/resolv.conf already exists" && return
	
	sudo sh -c 'chown aquawicket /etc'
	sudo sh -c 'echo "nameserver 8.8.8.8" 		 > /etc/resolv.conf'
	sudo sh -c 'echo "[network]" 					>> /etc/wsl.conf'
	sudo sh -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
	#sudo sh -c 'chattr +i /etc/resolv.conf'
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_wslFixNet
}
