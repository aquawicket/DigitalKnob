#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_wslFix()
#
#	Fix WSL retaining file permissions 
#	Reference: https://superuser.com/a/1392722/600216
#
#	Linux Path:							/etc/wsl.conf
#	Open /etc/wsl.conf in notepad:     	wsl /mnt/c/Windows/notepad.exe $(wslpath -w /etc/wsl.conf)
#	Open /etc in explorer:     			wsl /mnt/c/Windows/explorer.exe $(wslpath -w /etc)
dk_wslFix(){
	dk_debugFunc 0
	
	dk_call dk_notice "Applying WSL settings . . ."
	
	dk_call dk_validate sudo_exe "dk_call dk_depend sudo_exe"
	dk_call dk_debug "sudo_exe = ${sudo_exe}"
	
	###### wsl.conf ###### 
	#${sudo_exe} bash -c 'chown ${USER} /etc'
	sudo rm /etc/wsl.conf
	sudo bash -c 'echo " ">											/etc/wsl.conf'
	sudo bash -c 'echo "[boot]">>									/etc/wsl.conf'
	sudo bash -c 'echo "systemd=true">>								/etc/wsl.conf'
	sudo bash -c 'echo " ">>										/etc/wsl.conf'
	sudo bash -c 'echo "[automount]">>								/etc/wsl.conf'
	sudo bash -c 'echo "enabled = true">>							/etc/wsl.conf'
	sudo bash -c 'echo "root = /mnt/">>								/etc/wsl.conf'
	sudo bash -c 'echo "options = \"metadata,umask=22,fmask=11\"">>	/etc/wsl.conf'
	sudo bash -c 'echo " ">>										/etc/wsl.conf'
	sudo bash -c 'echo "[network]">>								/etc/wsl.conf'
	sudo bash -c 'echo "generateResolvConf = false">> 				/etc/wsl.conf'
	sudo bash -c 'echo " ">>										/etc/wsl.conf'
	sudo bash -c 'echo "[wsl2]">>									/etc/wsl.conf'
	sudo bash -c 'echo "networkingMode=mirrored">>					/etc/wsl.conf'
	sudo bash -c 'echo "dnsTunneling=true">>						/etc/wsl.conf'
	sudo bash -c 'echo "autoProxy=true">>							/etc/wsl.conf'
	sudo bash -c 'echo "guiApplications=true">>						/etc/wsl.conf'
	sudo bash -c 'echo " ">>										/etc/wsl.conf'
	#/mnt/c/Windows/notepad.exe $(wslpath -w /etc/wsl.conf)
	
	###### resolv.conf ######
	sudo rm /etc/resolv.conf
	sudo bash -c 'echo "nameserver 8.8.8.8"> 						/etc/resolv.conf'
	sudo bash -c 'echo " ">>										/etc/resolv.conf'
	sudo chattr +i /etc/resolv.conf
	#/mnt/c/Windows/notepad.exe $(wslpath -w /etc/resolv.conf)
	
	## https://wiki.debian.org/SourcesList#Example_sources.list
	sudo chmod 777 /etc/apt/sources.list
	/mnt/c/Windows/notepad.exe $(wslpath -w /etc/apt/sources.list)
}














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
    dk_call dk_wslFix
}
