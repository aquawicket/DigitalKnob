#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)						&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')						&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
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
		dk_call dk_validate DKHTTP_DKIMPORTS_DIR "export DKHTTP_DKIMPORTS_DIR=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/3rdParty/_DKIMPORTS"
		dk_call dk_download "${DKHTTP_DKIMPORTS_DIR}/git/DKINSTALL.sh"  "${DKIMPORTS_DIR}/git/DKINSTALL.sh"
	fi
	dk_call dk_depend git
	
#	if ! dk_call dk_commandExists git; then
#		dk_call dk_echo "dk_installPackage()"
#		dk_call dk_installPackage git
#	fi
#	GIT_EXE=$(command -v git)
#	[ -e "${GIT_EXE}" ] || dk_call dk_error "GIT_EXE is invalid"
#	dk_call dk_firewallAllow "Git" "C:\Users\Administrator\DigitalKnob\DKTools\git-portable-2.46.2-64-bit\mingw64\libexec\git-core\git-remote-https.exe"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_installGit
}
