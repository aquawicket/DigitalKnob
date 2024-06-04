@echo off
call DK

::################################################################################
::# dk_addContextMenu(<key> <menuTitle> <exe>)
::#
:dk_addContextMenu () {
    call dk_debugFunc
	if %__ARGC__% neq 3 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")

	call dk_set _key_ "%~1"
	call dk_set _menuTitle_ "%~2"
	call dk_set _exe_ "%~3"
	
	call dk_info "Adding '%_menuTitle_%' context menu to Windows using %GIT_EXE%"
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_key_%"
	REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_key_%" /ve /d "&%_menuTitle_%" /f
	REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_key_%" /v Icon /t REG_SZ /d "imageres.dll,-5324" /f
	REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\%_key_%\command" /ve /d "\"%_exe_%\" add \"%%1\"" /f
	
	call dk_pause
goto:eof






:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######

	call dk_validate DKIMPORTS_DIR dk_validateBranch
	call dk_validate GIT_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"
	call dk_addContextMenu "GITADD" "GIT ADD" "%GIT_EXE%"