#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)						&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')						&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


##################################################################################
# dk_createSymlink(src_path, symlink_path)
#
#
dk_createSymlink() {
	dk_debugFunc 2
	echo "dk_createSymlink($*)"
	
	[ ! -e ${1} ] && (dk_call dk_error "${1} does not exist"; return)
	[ -e ${2} ] && (dk_call dk_error "${2} already exists"; return)
	dk_call dk_basename ${2}
	[ ! -e ${dk_basename} ] && (dk_call dk_error "${dk_basename} not found" & return)
	
	LN_EXE=$(command -v ln)
	${LN_EXE} -s ${1} ${2}
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	### Create a directory symlink ###
    dk_call dk_createSymlink "${DKHOME_DIR}/DigitalKnob" "${DKHOME_DIR}/Desktop/DigitalKnob"
	
	### Create a file symlink ###
	#dk_call dk_createSymlink "${DKHOME_DIR}/DigitalKnob/Development/DKBatch/apps/DKBuilder/DKBuilder.sh" "${DKHOME_DIR}/Desktop/DKBuilder.sh" # OVERWRITE
	
	### Test Non-Existent Error ###
    #dk_call dk_createSymlink "${DKHOME_DIR}/Non-Existent" "${DKHOME_DIR}/Desktop/Non-Existent" 
}
