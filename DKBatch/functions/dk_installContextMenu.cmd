@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_installContextMenu(menuTitle, exe, command)
::#
:dk_installContextMenu
    call dk_debugFunc 3

	setlocal
	%dk_call% dk_set _menuTitle_ "%~1"
	%dk_call% dk_set _exe_ "%~2"
	%dk_call% dk_set _command_ "%~3"
	
	%dk_call% dk_info "Adding '%_menuTitle_%' context menu to Windows using %GIT_EXE%"
	
	::### delete existing key ###
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%"
	
	::### Menu Title ###
	::%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\%_menuTitle_%" "" "" "&%_menuTitle_%"
	::echo REG ADD "HKEY_CLASSES_ROOT\*\shell\%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
	::REG ADD "HKEY_CLASSES_ROOT\*\shell\%_menuTitle_%" /ve /d "&%_menuTitle_%" /f
	
	::### ICON ###
	::%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%" "Icon" "REG_SZ" "imageres.dll,-5324"
	echo REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_exe_%\"" /f
	REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%" /v Icon /t REG_SZ /d "\"%_exe_%\"" /f
	
	::### COMMAND <args> ###
	::%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\%_menuTitle_%\command" "" "" "%_command_%"
	echo REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
	REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_menuTitle_%\command" /ve /d "%_command_%" /f
	endlocal
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_validateBranch"
	%dk_call% dk_validate GIT_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"
	%dk_call% dk_installContextMenu "GITADD" "GIT ADD" "GIT_EXE" "\"%GIT_EXE%\" add \"%%1\""
goto:eof
