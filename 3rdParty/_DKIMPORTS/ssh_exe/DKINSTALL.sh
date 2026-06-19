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
# DKINSTALL
#
DKINSTALL() {
	dk_debugFunc 0

	(command -v "${ssh_exe-}" 1>/dev/null) && return $?;
	
	[ ! -e "${ssh_exe-}" ] && ssh_exe="${OpenSSH}/ssh"
	[ ! -e "${ssh_exe-}" ] && ssh_exe="/usr/bin/ssh"
	[ ! -e "${ssh_exe-}" ] && ssh_exe="C:/Windows/System32/OpenSSH/ssh.exe"
	[ ! -e "${ssh_exe-}" ] && (command -v 'cygpath' 1>/dev/null) && ssh_exe=$(cygpath -u "${ssh_exe}")
#	[ ! -e "${ssh_exe-}" ] && (command -v 'wslpath' 1>/dev/null) && ssh_exe=$(wslpath -u "${ssh_exe}")
	[ ! -e "${ssh_exe-}" ] && dk_call dk_installPackage ssh
	[ ! -e "${ssh_exe-}" ] && ssh_exe=$(command -v ssh)
	
	### Test exists
	[ -e "${ssh_exe-}" ] || { dk_call dk_error "ssh_exe:${ssh_exe} not found"; return $?; }
	
	### Test command
	(command -v "${ssh_exe-}" 1>/dev/null) || { dk_call dk_error "ssh_exe:${ssh_exe-} failed to run"; return $?; }
	
	###### return ######
	export ssh_exe=${ssh_exe};
	builtin echo "${ssh_exe}";
	return $?;
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_call dk_validate ssh_exe "dk_call dk_depend ssh_exe"
	dk_call dk_echo "ssh_exe = ${ssh_exe-}"
	
	dk_call dk_validate ssh_exe "dk_call dk_depend ssh_exe"
	dk_call dk_echo "ssh_exe = ${ssh_exe-}"
}