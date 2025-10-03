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
# dk_getUrl(<url> <ret:optional>)
#
dk_getUrl() {
	dk_debugFunc 1 2

	dk_call dk_validate curl_exe "dk_call dk_depend curl_exe"
	
	dk_getUrl=$(${curl_exe} -sI -o nul -w "%{redirect_url}" ${1})
	
	###### output ######
	export dk_getUrl=${dk_getUrl};
	if [ -n "${2-}" ]; then
		eval ${2}=${dk_getUrl};
	else
		builtin echo "${dk_getUrl}";
	fi
	return $?;
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	url="http://www.google.com/index.html"
	dk_call dk_getUrl "${url}"
	echo "url:'${url}' dk_getUrl = ${dk_getUrl}"
	
	url="http://www.nonexisting.com/nofile.no"
	dk_call dk_getUrl "${url}"
	echo "url:'${url}' dk_getUrl = ${dk_getUrl}"
	
	url="https://aka.ms/vs/16/release/VC_redist.x86.exe"
	dk_call dk_getUrl "${url}"
	echo "url:'${url}' dk_getUrl = ${dk_getUrl}"
	
	url="https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net35-sp1-offline-installer"
	dk_call dk_getUrl "${url}"
	echo "url:'${url}' dk_getUrl = ${dk_getUrl}"

}
