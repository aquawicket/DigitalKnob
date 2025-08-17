#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')									&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)										&& echo "BASH_EXE = ${BASH_EXE}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


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
