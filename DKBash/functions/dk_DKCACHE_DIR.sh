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
# dk_DKCACHE_DIR()
#
#
dk_DKCACHE_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKCACHE_DIR="${1}" 

	############ GET ############
	elif [ ! -e "${DKCACHE_DIR-}" ]; then
		dk_call dk_validate DKHOME_DIR "dk_call DKHOME_DIR" 
		export DKCACHE_DIR="${DKHOME_DIR}/.dk"  
	fi 
	if [ ! -e "${DKCACHE_DIR}" ]; then
		dk_call dk_mkdir "${DKCACHE_DIR}" 
	fi
	
	builtin echo "${DKCACHE_DIR-}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0 
   
	dk_call dk_echo
	dk_call dk_echo "Test Getting DKCACHE_DIR . . ."
	dk_call dk_DKCACHE_DIR
	dk_call dk_printVar DKCACHE_DIR
	
	dk_call dk_echo
	dk_call dk_echo "Test Setting DKCACHE_DIR . . ."
	dk_call dk_DKCACHE_DIR "/C/.dk"
	dk_call dk_printVar DKCACHE_DIR 
}
