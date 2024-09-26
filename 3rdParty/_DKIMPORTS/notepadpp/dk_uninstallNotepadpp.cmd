@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::####################################################################
::# dk_installNotepadpp()
::#
:dk_installNotepadpp
	call dk_debugFunc 0
	
	call dk_validate DK_HOST_OS "call dk_getHostTriple"
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_arm64"   call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86"     call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86_64"  call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip"
	if not defined NOTEPADPP_DL call dk_error "NOTEPADPP_DL is invalid"
	
	call dk_basename %NOTEPADPP_DL% NOTEPADPP_DL_FILE
	call dk_removeExtension %NOTEPADPP_DL_FILE% NOTEPADPP_FOLDER
	::call dk_convertToCIdentifier %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	call dk_toLower %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	call dk_validate DKTOOLS_DIR "call dk_DKTOOLS_DIR"
	call dk_set NOTEPADPP_DIR "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"

	::FIXME: kill notepad++.exe process
	call dk_delete "%NOTEPADPP_DIR%"
	
	::### Uninstall Context Menu ###
	call %DKIMPORTS_DIR%\notepadpp\dk_uninstallNotepadppContextMenu.cmd

	::### Uninstall File Associations ###
	call %DKIMPORTS_DIR%\notepadpp\dk_uninstallNotepadppFileAssociations.cmd
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_uninstallNotepadpp
%endfunction%
