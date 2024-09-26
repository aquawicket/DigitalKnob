@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_installNotepadpp()
::#
:dk_installNotepadpp
	call dk_debugFunc 0
	
	%dk_call% dk_validate DK_HOST_OS "%dk_call% dk_getHostTriple"
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_arm64"   %dk_call% dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86"     %dk_call% dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86_64"  %dk_call% dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip"
	if not defined NOTEPADPP_DL %dk_call% dk_error "NOTEPADPP_DL is invalid"
	
	%dk_call% dk_basename %NOTEPADPP_DL% NOTEPADPP_DL_FILE
	%dk_call% dk_removeExtension %NOTEPADPP_DL_FILE% NOTEPADPP_FOLDER
	::%dk_call% dk_convertToCIdentifier %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	%dk_call% dk_toLower %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set NOTEPADPP_DIR "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"
	
	%dk_call% dk_set NOTEPADPP_EXE "%NOTEPADPP_DIR%\notepad++.exe"
	
	if exist "%NOTEPADPP_EXE%" goto:notepadpp_installed
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing notepad++ . . ."
    %dk_call% dk_download %NOTEPADPP_DL%
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
    %dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\%NOTEPADPP_DL_FILE%" "%NOTEPADPP_DIR%"
	if NOT exist "%NOTEPADPP_EXE%" %dk_call% dk_error "cannot find NOTEPADPP_EXE:%NOTEPADPP_EXE%"
	:notepadpp_installed
	
	::### Add Dark Mode ###
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_validateBranch"
	%dk_call% dk_copy %DKIMPORTS_DIR%\notepadpp\dark_config.xml %NOTEPADPP_DIR%\config.xml OVERWRITE
	
	::### Add Context Menu ###
	call %DKIMPORTS_DIR%\notepadpp\dk_installNotepadppContextMenu.cmd
	
	::### Add File Associations ###
	call %DKIMPORTS_DIR%\notepadpp\dk_installNotepadppFileAssociations.cmd
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installNotepadpp
%endfunction%
