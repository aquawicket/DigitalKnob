@echo off
call ..\..\..\DKBatch\functions\DK.cmd

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
	
	if not defined DKTOOLS_DIR call dk_setDKTOOLS_DIR
	call dk_set NOTEPADPP "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"
	call dk_set NOTEPADPP_EXE "%NOTEPADPP%\notepad++.exe"
	
	if exist "%NOTEPADPP_EXE%" goto:notepadpp_installed
	call dk_echo   
    call dk_info "Installing notepad++ . . ."
    call dk_download %NOTEPADPP_DL%
    call dk_smartExtract "%DKDOWNLOAD_DIR%\%NOTEPADPP_DL_FILE%" "%NOTEPADPP%"
	if NOT exist "%NOTEPADPP_EXE%" call dk_error "cannot find NOTEPADPP_EXE:%NOTEPADPP_EXE%"
	:notepadpp_installed
	
	::### Add Dark Mode ###
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_copy %DKIMPORTS_DIR%\notepadpp\dark_config.xml %NOTEPADPP%\config.xml OVERWRITE
	
	::### Add Context Menu ###
	call %DKIMPORTS_DIR%\notepadpp\dk_installNotepadppContextMenu.cmd
	
	::### Add File Associations ###
	call %DKIMPORTS_DIR%\notepadpp\dk_installNotepadppFileAssociations.cmd
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_installNotepadpp
goto:eof
