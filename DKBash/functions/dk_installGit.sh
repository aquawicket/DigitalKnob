#!/bin/bash
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
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
