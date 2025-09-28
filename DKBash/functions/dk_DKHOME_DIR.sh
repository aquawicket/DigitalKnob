#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)								&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')								&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


####################################################################
# dk_DKHOME_DIR()
#
#
dk_DKHOME_DIR() {
    dk_debugFunc 0 1;

	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKHOME_DIR="${1}";
	
	############ GET ############
    elif [ ! -e "${DKHOME_DIR-}" ]; then
		###### cmd_exe ######
		echo "###### cmd_exe ######"
		[ ! -e "${cmd_exe-}" ]		&& export cmd_exe=$(command -v cmd.exe) || $(true);
		[ ! -e "${cmd_exe}" ]		&& export cmd_exe="C:/Windows/System32/cmd.exe";
		[ ! -e "${cmd_exe}" ]		&& unset cmd_exe;
		[   -e "${cmd_exe-}" ]		&& dk_call dk_printVar cmd_exe;
		
		######  USERPROFILE -> cygpath_exe -> DKHOME_DIR ######
		[ ! -e "${cygpath_exe-}" ]	&& export cygpath_exe=$(command -v "cygpath") || $(true);
		[   -e "${cygpath_exe}" ]	&& export USERPROFILE=$(${cygpath_exe} -u $(${cmd_exe} "/c echo %USERPROFILE% | tr -d '\r'"));
		[ ! -e "${cygpath_exe}" ]	&& unset cygpath_exe;
		[   -e "${cygpath_exe-}" ]	&& dk_call dk_printVar cygpath_exe;
		[   -e "${cygpath_exe-}" ]	&& export DKHOME_DIR=$(cygpath -u $(${cmd_exe} "/c echo %USERPROFILE% | tr -d '\r'"));
		
		######  USERPROFILE -> wslpath_exe -> DKHOME_DIR ######
		[ ! -e "${wslpath_exe-}" ]	&& export wslpath_exe=$(command -v "wslpath") || $(true);
		[   -e "${wslpath_exe}" ]	&& export USERPROFILE=$(${wslpath_exe} -u $(${cmd_exe} /c echo "%USERPROFILE%" | tr -d '\r'));
		[ ! -e "${wslpath_exe}" ]	&& unset wslpath_exe;
		[   -e "${wslpath_exe-}" ]	&& dk_call dk_printVar wslpath_exe;
		[   -e "${wslpath_exe-}" ]	&& export DKHOME_DIR=$(wslpath -u $(${cmd_exe} /c echo "%USERPROFILE%" | tr -d '\r'));
		
		### DKHOME_DIR ###
		#[ ! -e "${DKHOME_DIR-}" ]   && [ -e "$(grep -o "/storage/....-...." /proc/mounts)" ] && export DKHOME_DIR=$(grep -o "/storage/....-...." /proc/mounts) # Android sdcard
		[ ! -e "${DKHOME_DIR-}" ] 	&& export DKHOME_DIR="${HOME}";
		[   -e "${DKHOME_DIR-}" ]	&& dk_call dk_printVar DKHOME_DIR;
		[ ! -e "${DKHOME_DIR}" ] 	&& dk_call dk_fatal "DKHOME_DIR not found";
	fi
	
	export DKHTTP_DKHOME_DIR="https://raw.githubusercontent.com/aquawicket";
	builtin echo "${DKHOME_DIR-}";
	true;
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0;
 
	dk_call dk_echo;
	dk_call dk_echo "Test Getting DKHOME_DIR . . .";
	dk_call dk_echo "DKHOME_DIR = $(dk_call dk_DKHOME_DIR)";
	
	dk_call dk_echo;
	dk_call dk_echo "Test Setting DKHOME_DIR . . .";
	dk_call dk_echo "DKHOME_DIR = $(dk_call dk_DKHOME_DIR '/c/')";
}
