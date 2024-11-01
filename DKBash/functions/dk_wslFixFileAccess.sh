#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

####################################################################
# dk_SUDO_EXE()
#
#	Fix WSL retaining file permissions 
# https://superuser.com/a/1392722/600216
#
dk_wslFixFileAccess(){
	dk_debugFunc 0
	echo "dk_wslFixFileAccess.sh()"
	
	[ ! -n "${WSLPATH_EXE-}" ] && return
	
	echo "Applying WSL file access fix"
	[ ! -e "/etc" ] && echo "ERROR: /etc directory does not exist"
	[   -e "/etc/wsl.conf" ] && echo "/etc/wsl.conf already exists" && return
	
	$(dk_call dk_SUDO_EXE) sh -c 'echo "" 									 > "/etc/wsl.conf"'
	$(>> "/etc/wsl.conf"') sh -c 'echo "[boot]" 							>> "/etc/wsl.conf"'
	$(dk_SUDO_EXE) sh -c 'echo "systemd=true"								>> "/etc/wsl.conf"'
	$(dk_SUDO_EXE) sh -c 'echo ""											>> "/etc/wsl.conf"'
	$(dk_SUDO_EXE) sh -c 'echo "[automount]"								>> "/etc/wsl.conf"'
	$(dk_SUDO_EXE) sh -c 'echo "enabled = true"								>> "/etc/wsl.conf"'
	$(dk_SUDO_EXE) sh -c 'echo "root = /mnt/"								>> "/etc/wsl.conf"'
	$(dk_SUDO_EXE) sh -c 'echo "options = \"metadata,umask=22,fmask=11\"" 	>> "/etc/wsl.conf"'
	$(dk_SUDO_EXE) sh -c 'echo ""											>> "/etc/wsl.conf"'
	$(dk_SUDO_EXE) sh -c 'echo "[network]" 									>> "/etc/wsl.conf"'
	$(dk_SUDO_EXE) sh -c 'echo "generateResolvConf = false" 				>> "/etc/wsl.conf"'
	$(dk_SUDO_EXE) sh -c 'echo "[network]" 									>> "/etc/wsl.conf"'
	$(dk_SUDO_EXE) sh -c 'echo "generateResolvConf = false" 				>> "/etc/wsl.conf"'
	echo "RELOADING WSL . . . " >&2
	wsl --shutdown
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
    dk_call dk_wslFixFileAccess
}
