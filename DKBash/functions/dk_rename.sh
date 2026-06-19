#!/bin/sh
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


##################################################################################
# dk_rename(<from> <to>)
#
#	Rename file or directory or move a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing files is enabled
#
dk_rename() {
	dk_debugFunc 2

	_from_="${1}"
	_to_="${2}"
	#OVERWRITE=     TODO
	
	dk_call dk_info "Renameing ${_from_} to ${_to_}"
	
	if ! dk_call dk_pathExists "${_from_}"; then
		dk_call dk_error "dk_rename: ${_from_} not found"
	fi
	
	if dk_call dk_pathExists "${_to_}"; then
		#if [ $OVERWRITE -ne 1 ]; then
		#	dk_error "dk_rename(): Cannot rename file. Destiantion exists and not set to OVERWRITE"
		#fi
		dk_call dk_delete ${_to_}
	fi
	
	# the base directory of the ${_to_} path must exist.    
	parent_dir=$(dk_dirname ${_to_})
	dk_call dk_printVar parent_dir
	dk_call dk_mkdir "${parent_dir}"
	
	timestamp=$(stat -c %y ${_from_});
	echo "_from_ timestamp = $timestamp";
	mv -i ${_from_} ${_to_};   # -i means interactive, to prevent overwrite
	touch -d "$timestamp" ${_to_};
	timestamp=$(stat -c %y ${_to_});
	echo "_to_ timestamp = $timestamp";
	#[ ? = "success" ]
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	echo "rename this file" > renameMe.txt
	dk_rename renameMe.txt iWasRenamed.txt
	
	dk_mkdir renameMe
	dk_rename renameMe iWasRenamed
}