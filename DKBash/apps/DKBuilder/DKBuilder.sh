#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin;
	(command -v 'cygpath' 1>/dev/null)	&& HOME=$(cygpath -u $USERPROFILE)											&& echo "cygpath: HOME = ${HOME}";
	(command -v 'cmd.exe' 1>/dev/null)	&& cmd_exe=$(command -v 'cmd.exe')											&& echo "cmd_exe = ${cmd_exe}";
	(command -v 'cmd.exe' 1>/dev/null)	&& USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')				&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}";
	(command -v 'wslpath' 1>/dev/null)	&& HOME=$(wslpath -u ${USERPROFILE})										&& echo "wslpath: HOME = ${HOME}";
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}";
	[ ! -e "${DK_SH}" ]					&& export DK_SH="$(dirname $(dirname $(dirname $0)))/functions/DK.sh"		&& echo "DK_SH = ${DK_SH}";
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}";
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}";
	[ ! -e "${DK_SH}" ]					&& [ -z "${HDK_SH}" ] && export HDK_SH="http://aquawicket.com/DigitalKnob/Development/DKBash/functions/DK.sh";
	[ ! -e "${DK_SH}" ]					&& mkdir -p "$(dirname ${DK_SH})";
	#[ ! -e "${DK_SH}" ]			 	&& [ -e "$(curl_exe)" ] && dk_call dk_firewallAllow "CURL" "$(curl_exe)" 	&& $(curl_exe) --silent --show-error --location --create-dirs --output "${DK_SH}" "${HDK_SH}";
	[ ! -e "${DK_SH}" ]  				&& (command -v curl) 														&& curl --location --output "${DK_SH}" "${HDK_SH}";
	[ ! -e "${DK_SH}" ]  				&& (command -v wget) 														&& wget -P "${DK_SH}" "${HDK_SH}";
	#[ ! -e "${DK_SH}" ]  				&& (echo "DK_SH:${DK_SH} does not exist"; exit ${BASH_LINENO[0]};) 
	#[ -e "$(sudo_exe)" ] 				&& $(sudo_exe) chmod 777 "${DK_SH}";
	[ -z "${DKStorage_DIR-}" ]			&& export DKStorage_DIR="${HOME}/DigitalKnob/DKStorage"						&& echo "DKStorage_DIR = ${DKStorage_DIR}";
	[ ! -e "${DKStorage_DIR}" ]			&& mkdir -p "${DKStorage_DIR}";
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*;
fi



DKBuilder() {
	dk_debugFunc 0;
	
	dk_call dk_buildMain;
}
