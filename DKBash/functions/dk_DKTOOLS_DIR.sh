#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


####################################################################
# dk_DKTOOLS_DIR()
#
#
dk_DKTOOLS_DIR() {
    dk_debugFunc 0 1

	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKTOOLS_DIR="${1}" 

	############ GET ############
	else
		[ -n "${DKTOOLS-}" ] 		|| export DKTOOLS="DKTools"
		[ -n "${DKTOOLS_DIR-}" ] 	|| export DKTOOLS_DIR="$(dk_call dk_DIGITALKNOB_DIR)/DKTools"  
	fi
	
	########## FINALIZE ############
	if [ ! -e "${DKTOOLS_DIR}" ]; then
		dk_call dk_mkdir "${DKTOOLS_DIR}" 
	fi
	
	builtin echo "${DKTOOLS_DIR-}"
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0 
	
	# Using command substitution
	dk_call dk_echo;
	dk_call dk_echo "Test Getting DKTOOLS_DIR . . .";
    dk_call dk_echo "DKTOOLS_DIR = '$(dk_call dk_DKTOOLS_DIR)'";
	
	dk_call dk_echo;
	dk_call dk_echo "Test Setting DKTOOLS_DIR . . .";
	dk_call dk_echo "DKTOOLS_DIR = '$(dk_call dk_DKTOOLS_DIR '/c/Digital Knob/DKTools')'";
	
	# Using global variable
	dk_call dk_DKTOOLS_DIR
	dk_call dk_echo "DKTOOLS_DIR = '${DKTOOLS_DIR}'";
	
	dk_call dk_DKTOOLS_DIR "/c/Digital Knob/DKTools"
	dk_call dk_echo "DKTOOLS_DIR = '${DKTOOLS_DIR}'";
}
