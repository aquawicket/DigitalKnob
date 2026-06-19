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


###############################################################################
# dk_DK3RDPARTY_DIR()
#
#
dk_DK3RDPARTY_DIR() {
	dk_debugFunc 0 1
	
	############ SET ############
	if [ -n "${1-}" ]; then  
		export DK3RDPARTY_DIR="${1}" 

	############ GET ############
	elif [ ! -e "${DK3RDPARTY_DIR-}" ]; then
		dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR" 
		export DK3RDPARTY_DIR="${DKBRANCH_DIR}/3rdParty"   
	fi
	
	builtin echo "${DK3RDPARTY_DIR-}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "Test Getting DK3RDPARTY_DIR . . ."
	dk_call dk_DK3RDPARTY_DIR
	dk_call dk_printVar DK3RDPARTY_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DK3RDPARTY_DIR . . ."
	dk_call dk_DK3RDPARTY_DIR "/C/DK/3rdParty"
	dk_call dk_printVar DK3RDPARTY_DIR 
}
