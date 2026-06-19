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


################################################################################
# dk_addContextMenu(menuTitle, exe, command)
dk_call dk_fixme()
#
dk_addContextMenu() {
    dk_debugFunc 3

	dk_call dk_set _menuTitle_ "${1}"
	dk_call dk_set _exe_ "${2}"
	dk_call dk_set _command_ "${3}"
	
	dk_call dk_info "Adding '${_menuTitle_}' context menu to Windows using ${git_exe}"
	
	### delete existing key ###
	dk_call dk_registryDeleteKey "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\${_menuTitle_}"
	
	### Menu Title ###
	#call dk_call dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\${_menuTitle_}" "" "" "&${_menuTitle_}"
	#echo REG ADD "HKEY_CLASSES_ROOT\*\shell\${_menuTitle_}" /ve /d "&${_menuTitle_}" /f
	#REG ADD "HKEY_CLASSES_ROOT\*\shell\${_menuTitle_}" /ve /d "&${_menuTitle_}" /f
	
	### ICON ###
	#dk_call dk_registrySetKey "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\${_menuTitle_}" "Icon" "REG_SZ" "imageres.dll,-5324"
	
	#dk_call dk_echo REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\${_menuTitle_}" /v Icon /t REG_SZ /d "\"${_exe_}\"" /f
	REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\${_menuTitle_}" /v Icon /t REG_SZ /d "\"${_exe_}\"" /f
	
	### COMMAND <args> ###
	#dk_call dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\${_menuTitle_}\command" "" "" "${_command_}"
	
	#dk_call dk_echo REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\${_menuTitle_}\command" /ve /d "${_command_}" /f
	REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\${_menuTitle_}\command" /ve /d "${_command_}" /f
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	dk_call dk_validate git_exe "dk_call dk_installGit"
	dk_call dk_addContextMenu "GITADD" "GIT ADD" "git_exe" "\"${git_exe}\" add \"%%1\""
}
