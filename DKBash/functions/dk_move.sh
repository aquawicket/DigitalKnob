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


##################################################################################
# dk_move(<from> <to>)
#
#	Move/Rename a file or directory to another location/name
#
#	@from		- The source path to move or rename
#	@to			- The destination path to move or rename to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
#
dk_move() {
	dk_debugFunc 2 3

	
	local _from_=${1}
	local _to_=${2}

	[ "${3}" = "OVERWRITE" ] && OVERWRITE=1
	
	dk_call dk_info "Moving $_from_ to $_to_"
	
	if ! dk_call dk_pathExists "$_from_"; then
		dk_call dk_error "dk_move: $_from_ not found"
	fi
	
	if dk_call dk_pathExists "$_to_"; then
		if [ $OVERWRITE -ne 1 ]; then
			dk_call dk_error "dk_rename Cannot move file. Destiantion exists and OVERWRITE is not set"
		fi
		dk_call dk_delete $_to_
	fi
	
	# the base directory of the ${_to_} path must exist.    
	_parent_dir_=$(dk_call dk_dirname "${_to_}")
	dk_call dk_printVar _parent_dir_
	dk_call dk_mkdir "${_parent_dir_}"
	
	mv "${_from_}" "${_to_}"
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST(){
	dk_debugFunc 0
	
	dk_validate DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR"
	
	echo "dk_move test" > ${DKDOWNLOAD_DIR}/moveMe.file
	dk_move ${DKDOWNLOAD_DIR}/moveMe.file ${DIGITALKNOB_DIR}/iWasMoved.txt OVERWRITE
	
	echo "dk_move test" > moveMe.file
	dk_move moveMe.file iWasMoved.txt OVERWRITE
	
	dk_mkdir ${DKDOWNLOAD_DIR}/moveMe
	dk_move ${DKDOWNLOAD_DIR}/moveMe ${DIGITALKNOB_DIR}/iWasMoved OVERWRITE
	
	dk_mkdir moveMe
	dk_move moveMe iWasMoved OVERWRITE
}
