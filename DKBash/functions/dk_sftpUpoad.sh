#!/bin/bash
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


############################################################################
# dk_sftpUpoad(localPath remotePath)
#
# 	Reference: https://man7.org/linux/man-pages/man1/sftp.1.html
#
dk_sftpUpoad() {
 	dk_debugFunc 2 

	localPath="$1";
	dk_call dk_debug "localPath = ${localPath}";
	remotePath="$2";
	dk_call dk_debug "remotePath = ${remotePath}";
	
	#dk_call dk_validate sftp_exe "dk_call dk_depend OpenSSH";
	export sftp_exe=$(which sftp);
	
	[ -z "${sftp_user-}" ] && sftp_user="u108565871";
	dk_call dk_debug "sftp_user = ${sftp_user}";
	
	[ -z "${sftp_server-}" ] && sftp_server="access912915170.webspace-data.io";
	dk_call dk_debug "sftp_server = ${sftp_server}";
	
	[ -z "${sftp_port-}" ] && sftp_port=22;
	dk_call dk_debug "sftp_port = ${sftp_port}";
	
	remoteDir=$(dk_call dk_dirname "${remotePath}");
	dk_call dk_debug "remoteDir = ${remoteDir}";
	
	
	###### CONNECT & UPLOAD ######
	dk_call dk_assertPath "${localPath}";
	
	# https://www.filestash.app/sftp-curl.html
	(command -v 'wslpath' 1>/dev/null) && dk_call dk_wslFix
	echo "enter sftp password"
	read sftp_pass
	curl -T ${localPath} -k --user "${sftp_user}:${sftp_pass}" sftp://${sftp_server}${remoteDir}/
}











####### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;

	[ -z "${DKStorage_DIR-}" ] && export DKStorage_DIR="${HOME}/DigitalKnob/DKStorage"
	dk_call dk_sftpUpoad "${DKStorage_DIR}/DigitalKnob.bundle" "/DigitalKnob/DKStorage/DigitalKnob.bundle";
}

