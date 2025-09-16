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


#####################################################################
# dk_Host_Tuple()
#
#
dk_Host_Tuple() {
	dk_debugFunc 0 1
 		
	###### SET ######
	if [ -n "${1-}" ]; then
		Host_Tuple="$1"
	
	###### GET ######	
	else
		[ -z "${Host_Os-}" ]	&& dk_call dk_Host_Os
		[ -z "${Host_Arch-}" ]	&& dk_call dk_Host_Arch
		Host_Tuple="${Host_Os-}_${Host_Arch-}"
	fi
	
	export ${Host_Tuple}_Host=1
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

    ###### GET ######
    dk_call dk_Host_Tuple
	dk_call dk_printVar Host_Tuple
	dk_call dk_printVar ${Host_Tuple}_Host
	
	###### SET ######
	dk_call dk_Host_Tuple "Linux_I686"
	dk_call dk_printVar Host_Tuple
	dk_call dk_printVar ${Host_Tuple}_Host
}