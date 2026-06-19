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
# dk_installGit()
#
#
dk_installGit() {
	dk_debugFunc 0
	#echo "dk_installGit($*)"
	
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	if [ ! -e "${DKIMPORTS_DIR}/git/DKINSTALL.sh" ]; then
		dk_call dk_validate DKHTTP_DKIMPORTS_DIR "export DKHTTP_DKIMPORTS_DIR=http://aquawicket.com/DigitalKnob/Development/3rdParty/_DKIMPORTS"
		dk_call dk_download "${DKHTTP_DKIMPORTS_DIR}/git/DKINSTALL.sh"  "${DKIMPORTS_DIR}/git/DKINSTALL.sh"
	fi
	dk_call dk_depend git
	
#	if ! dk_call dk_commandExists git; then
#		dk_call dk_echo "dk_installPackage()"
#		dk_call dk_installPackage git
#	fi
#	git_exe=$(command -v git)
#	[ -e "${git_exe}" ] || dk_call dk_error "git_exe is invalid"
#	dk_call dk_firewallAllow "Git" "C:\Users\Administrator\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\mingw64\libexec\git-core\git-remote-https.exe"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_installGit
}
