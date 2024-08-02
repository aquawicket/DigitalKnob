@echo off
call "..\..\..\DKBatch\functions\DK.cmd"


::####################################################################
::# dk_installNotepadpp()
::#
:dk_installNotepadpp
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_validate HOST_OS "call dk_getHostTriple"
	if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"   call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"     call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"  call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip"
	if not defined NOTEPADPP_DL call dk_error "NOTEPADPP_DL is invalid"
	
	call dk_basename %NOTEPADPP_DL% NOTEPADPP_DL_FILE
	call dk_removeExtension %NOTEPADPP_DL_FILE% NOTEPADPP_FOLDER
	call dk_convertToCIdentifier %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	call dk_toLower %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER

	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set NOTEPADPP_DIR "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"

	::FIXME: kill notepad++.exe process
	call dk_delete "%NOTEPADPP_DIR%"
	
	::### Uninstall Context Menu ###
	call %DKIMPORTS_DIR%\notepadpp\dk_uninstallNotepadppContextMenu.cmd

	::### Uninstall File Associations ###
	call %DKIMPORTS_DIR%\notepadpp\dk_uninstallNotepadppFileAssociations.cmd
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
    call dk_uninstallNotepadpp
goto:eof
