#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


####################################################################
# dk_SUDO_EXE()
#
#	Fix WSL retaining file permissions 
# https://superuser.com/a/1392722/600216
#
dk_wslFixFileAccess(){
	dk_debugFunc 0
	echo "dk_wslFixFileAccess.sh()"
	
#	[ ! -n "${WSLPATH_EXE-}" ] && return
	
	echo "Applying WSL file access fix"
#	[ ! -e "/etc" ] && echo "ERROR: /etc directory does not exist"
#	[   -e "/etc/wsl.conf" ] && echo "/etc/wsl.conf already exists" && return
	
	sudo sh -c 'chown aquawicket /etc'
	sudo sh -c 'touch /etc/wsl.conf'
	sudo sh -c 'echo " "			 							> /etc/wsl.conf'
	sudo sh -c 'echo "[boot]" 									>> /etc/wsl.conf'
	sudo sh -c 'echo "systemd=true"								>> /etc/wsl.conf'
	sudo sh -c 'echo " "										>> /etc/wsl.conf'
	sudo sh -c 'echo "[automount]"								>> /etc/wsl.conf'
	sudo sh -c 'echo "enabled = true"							>> /etc/wsl.conf'
	sudo sh -c 'echo "root = /mnt/"								>> /etc/wsl.conf'
	sudo sh -c 'echo "options = \"metadata,umask=22,fmask=11\"" >> /etc/wsl.conf'
	sudo sh -c 'echo " "										>> /etc/wsl.conf'
	sudo sh -c 'echo "[network]" 								>> /etc/wsl.conf'
	sudo sh -c 'echo "generateResolvConf = false" 				>> /etc/wsl.conf'
	sudo sh -c 'echo " "										>> /etc/wsl.conf'
	sudo sh -c 'echo "[wsl2]"									>> /etc/wsl.conf'
	sudo sh -c 'echo "networkingMode=mirrored"					>> /etc/wsl.conf'
	sudo sh -c 'echo "dnsTunneling=true"						>> /etc/wsl.conf'
	sudo sh -c 'echo "autoProxy=true"							>> /etc/wsl.conf'
	sudo sh -c 'echo "guiApplications=true"						>> /etc/wsl.conf'
	sudo sh -c 'echo " "										>> /etc/wsl.conf'
	sudo sh -c 'echo " "										>> /etc/wsl.conf'
	
	
	
	
	
	
	




	
	
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
    dk_call dk_wslFixFileAccess
}
