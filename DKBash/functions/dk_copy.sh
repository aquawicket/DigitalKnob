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


##################################################################################
# dk_copy(<from> <to>)
#
#	copy a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
#
dk_copy() {
	dk_debugFunc 2 3

	local _from_="${1}"
	local _to_="${2}"
	if [ "${3-}" = "OVERWRITE" ]; then
		OVERWRITE=1
	else 
		OVERWRITE=0 
	fi
	
	dk_call dk_info "Copying ${_from_} to ${_to_}"
	
	if [ ! -e "${_from_}" ]; then
		dk_call dk_error "dk_copy: ${_from_} not found"
	fi
	
	if [ -e "${_to_}" ]; then
		if [ "${OVERWRITE}" -ne "1" ]; then
			dk_call dk_error "dk_copy Cannot copy file. Destiantion exists and OVERWRITE is not set"
		fi
		dk_call dk_delete ${_to_}
	fi
	
	# the base directory of the ${_to_} path must exist.    
	_parent_dir_=$(dk_call dk_dirname "${_to_}")
	dk_call dk_mkdir "${_parent_dir_}"
	
	cp -r "${_from_}" "${_to_}"

	#TODO
	#[ ? = "success" ]
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR"
	
	dk_call dk_echo "dk_copy test" > ${DKDOWNLOAD_DIR}/copyMe.file
	dk_call dk_copy ${DKDOWNLOAD_DIR}/copyMe.file ${DIGITALKNOB_DIR}/iWasCopied.txt OVERWRITE
	
	dk_call dk_echo "dk_copy test" > copyMe.file
	dk_call dk_copy copyMe.file iWasCopied.txt OVERWRITE
	
	dk_call dk_mkdir ${DKDOWNLOAD_DIR}/copyMe
	dk_call dk_copy ${DKDOWNLOAD_DIR}/copyMe ${DIGITALKNOB_DIR}/iWasCopied OVERWRITE
	
	dk_call dk_mkdir copyMe
	dk_call dk_copy copyMe iWasCopied OVERWRITE
}
