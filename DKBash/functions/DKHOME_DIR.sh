#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


####################################################################
# DKHOME_DIR()
#
#
DKHOME_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKHOME_DIR="${1}"
	
	############ GET ############
    elif [ ! -e "${DKHOME_DIR-}" ]; then
		###### CMD_EXE ######
		echo "###### CMD_EXE ######"
		[ ! -e "${CMD_EXE-}" ]		&& export CMD_EXE=$(command -v cmd.exe) || $(true)
		[ ! -e "${CMD_EXE}" ]		&& export CMD_EXE="C:/Windows/System32/cmd.exe"
		[ ! -e "${CMD_EXE}" ]		&& unset CMD_EXE
		[   -e "${CMD_EXE-}" ]		&& dk_call dk_printVar CMD_EXE
		
		######  USERPROFILE -> CYGPATH_EXE -> DKHOME_DIR ######
		[ ! -e "${CYGPATH_EXE-}" ]	&& export CYGPATH_EXE=$(command -v "cygpath") || $(true)
		[   -e "${CYGPATH_EXE}" ]	&& export USERPROFILE=$(${CYGPATH_EXE} -u $(${CMD_EXE} "/c echo %USERPROFILE% | tr -d '\r'"))
		[ ! -e "${CYGPATH_EXE}" ]	&& unset CYGPATH_EXE
		[   -e "${CYGPATH_EXE-}" ]	&& dk_call dk_printVar CYGPATH_EXE
		[   -e "${CYGPATH_EXE-}" ]	&& export DKHOME_DIR=$(cygpath -u $(${CMD_EXE} "/c echo %USERPROFILE% | tr -d '\r'"))
		
		######  USERPROFILE -> WSLPATH_EXE -> DKHOME_DIR ######
		[ ! -e "${WSLPATH_EXE-}" ]	&& export WSLPATH_EXE=$(command -v "wslpath") || $(true)
		[   -e "${WSLPATH_EXE}" ]	&& export USERPROFILE=$(${WSLPATH_EXE} -u $(${CMD_EXE} /c echo "%USERPROFILE%" | tr -d '\r'))
		[ ! -e "${WSLPATH_EXE}" ]	&& unset WSLPATH_EXE
		[   -e "${WSLPATH_EXE-}" ]	&& dk_call dk_printVar WSLPATH_EXE
		[   -e "${WSLPATH_EXE-}" ]	&& export DKHOME_DIR=$(wslpath -u $(${CMD_EXE} /c echo "%USERPROFILE%" | tr -d '\r'))
		
		### DKHOME_DIR ###
		#[ ! -e "${DKHOME_DIR-}" ]   && [ -e "$(grep -o "/storage/....-...." /proc/mounts)" ] && export DKHOME_DIR=$(grep -o "/storage/....-...." /proc/mounts) # Android sdcard
		[ ! -e "${DKHOME_DIR-}" ] 	&& export DKHOME_DIR="${HOME}"
		[   -e "${DKHOME_DIR-}" ]	&& dk_call dk_printVar DKHOME_DIR
		[ ! -e "${DKHOME_DIR}" ] 	&& dk_call dk_fatal "DKHOME_DIR not found"
	fi
	
	builtin echo "${DKHOME_DIR-}"
	true
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
 
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKHOME_DIR . . ."
    dk_call DKHOME_DIR
    dk_call dk_echo "DKHOME_DIR = ${DKHOME_DIR}"
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKHOME_DIR . . ."
	dk_call DKHOME_DIR "/c/"
	dk_call dk_echo "DKHOME_DIR = ${DKHOME_DIR}"
}
