#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"
dk_fixme()

################################################################################
# dk_addContextMenu(menuTitle, exe, command)
#
#
dk_addContextMenu (){
    dk_debugFunc
	[ ${#} -lt 3 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"

	dk_set _menuTitle_ "${1}"
	dk_set _exe_ "${2}"
	dk_set _command_ "${3}"
	
	dk_info "Adding '${_menuTitle_}' context menu to Windows using ${GIT_EXE}"
	
	### delete existing key ###
	dk_registryDeleteKey "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\${_menuTitle_}"
	
	### Menu Title ###
	#call dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\${_menuTitle_}" "" "" "&${_menuTitle_}"
	#echo REG ADD "HKEY_CLASSES_ROOT\*\shell\${_menuTitle_}" /ve /d "&${_menuTitle_}" /f
	#REG ADD "HKEY_CLASSES_ROOT\*\shell\${_menuTitle_}" /ve /d "&${_menuTitle_}" /f
	
	### ICON ###
	#dk_registrySetKey "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\${_menuTitle_}" "Icon" "REG_SZ" "imageres.dll,-5324"
	
	#dk_echo REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\${_menuTitle_}" /v Icon /t REG_SZ /d "\"${_exe_}\"" /f
	REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\${_menuTitle_}" /v Icon /t REG_SZ /d "\"${_exe_}\"" /f
	
	### COMMAND <args> ###
	#dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\${_menuTitle_}\command" "" "" "${_command_}"
	
	#dk_echo REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\${_menuTitle_}\command" /ve /d "${_command_}" /f
	REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\${_menuTitle_}\command" /ve /d "${_command_}" /f
}






DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
	dk_debugFunc
	
	dk_validate DKIMPORTS_DIR "dk_validateBranch"
	dk_validate GIT_EXE "${DKIMPORTS_DIR}/git/dk_installGit"
	dk_addContextMenu "GITADD" "GIT ADD" "GIT_EXE" "\"${GIT_EXE}\" add \"%%1\""
}
