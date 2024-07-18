@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_installContextMenu(menuTitle, exe, command)
::#
:dk_installContextMenu
    call dk_debugFunc
	if %__ARGC__% lss 3 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"

	call dk_set _menuTitle_ "%~1"
	call dk_set _exe_ "%~2"
	call dk_set _command_ "%~3"
	
	call dk_info "Adding '%_menuTitle_%' context menu to Windows using %GIT_EXE%"
	
	::### delete existing key ###
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%"
	
	::### Menu Title ###
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\%_menuTitle_%" "" "" "&%_menuTitle_%"
	::echo REG ADD "HKEY_CLASSES_ROOT\*\shell\%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
	::REG ADD "HKEY_CLASSES_ROOT\*\shell\%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
	
	::### ICON ###
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%" "Icon" "REG_SZ" "imageres.dll,-5324"
	echo REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_exe_%\"" /f
	REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_exe_%\"" /f
	
	::### COMMAND <args> ###
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\%_menuTitle_%\command" "" "" "%_command_%"
	echo REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
	REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate GIT_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"
	call dk_installContextMenu "GITADD" "GIT ADD" "GIT_EXE" "\"%GIT_EXE%\" add \"%%1\""
goto:eof
