@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installNotepadpp()
::#
:dk_installNotepadpp () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	
	call dk_validate HOST_OS "dk_getHostTriple"
	
	if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"   call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"     call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"  call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip"
	
	if not defined NOTEPADPP_DL call dk_error "NOTEPADPP_DL is invalid"
	
	call dk_getFilename %NOTEPADPP_DL% NOTEPADPP_DL_FILE
	call dk_removeExtension %NOTEPADPP_DL_FILE% NOTEPADPP_FOLDER
	call dk_convertToCIdentifier %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	call dk_toLower %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER

	call dk_validate DKTOOLS_DIR "dk_getDKPaths"
	call dk_set NOTEPADPP "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"
	call dk_set NOTEPADPP_EXE "%NOTEPADPP%\notepad++.exe"
	
	if exist "%NOTEPADPP_EXE%" goto:notepadpp_installed
	
	call dk_echo   
    call dk_info "Installing notepad++ . . ."
    call dk_download %NOTEPADPP_DL% "%DKDOWNLOAD_DIR%\%NOTEPADPP_DL_FILE%"
    call dk_smartExtract "%DKDOWNLOAD_DIR%\%NOTEPADPP_DL_FILE%" "%NOTEPADPP%"
	
	if NOT exist "%NOTEPADPP_EXE%" call dk_error "cannot find notepad++.exe"
	
	
	:notepadpp_installed
	
	:::::: dark mode ###
	call dk_validate DKIMPORTS_DIR "dk_validateBranch"
	call dk_copy %DKIMPORTS_DIR%\notepadpp\dark_config.xml %NOTEPADPP%\config.xml OVERWRITE
	
	
	
	:::::: Add Context Menu
	call %DKIMPORTS_DIR%\notepadpp\dk_installNotepadppContextMenu.cmd
	::call dk_info "Adding ^'Edit with Notepad++^' context menu to Windows..." 
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" "Icon" "REG_SZ" "\"%NOTEPADPP_EXE%\""
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++\command" "" "" "\"%NOTEPADPP_EXE%\" \"%%%%1\""
	

	:::::: associateFiles.cmd ###
	call %DKIMPORTS_DIR%\notepadpp\dk_installNotepadppFileAssociations.cmd
	::call dk_setFileAssoc .1 %NOTEPADPP_EXE%
	::call dk_setFileAssoc .2 %NOTEPADPP_EXE%
	::call dk_setFileAssoc .3 %NOTEPADPP_EXE%
	::call dk_setFileAssoc . %NOTEPADPP_EXE%
	::call dk_setFileAssoc .androidproj %NOTEPADPP_EXE%
	::call dk_setFileAssoc .backup %NOTEPADPP_EXE%
	::call dk_setFileAssoc .bak %NOTEPADPP_EXE%
	::call dk_setFileAssoc .c %NOTEPADPP_EXE%
	::call dk_setFileAssoc .cmake %NOTEPADPP_EXE%
	::call dk_setFileAssoc .cpp %NOTEPADPP_EXE%
	::call dk_setFileAssoc .css %NOTEPADPP_EXE%
	::call dk_setFileAssoc .data %NOTEPADPP_EXE%
	::call dk_setFileAssoc .gitattributes %NOTEPADPP_EXE%
	::call dk_setFileAssoc .gitconfig %NOTEPADPP_EXE%
	::call dk_setFileAssoc .glsl %NOTEPADPP_EXE%
	::call dk_setFileAssoc .gradle %NOTEPADPP_EXE%
	::call dk_setFileAssoc .h %NOTEPADPP_EXE%
	::call dk_setFileAssoc .htm %NOTEPADPP_EXE%
	::call dk_setFileAssoc .html %NOTEPADPP_EXE%
	::call dk_setFileAssoc .java %NOTEPADPP_EXE%
	::call dk_setFileAssoc .js %NOTEPADPP_EXE%
	::call dk_setFileAssoc .json %NOTEPADPP_EXE%
	::call dk_setFileAssoc .make %NOTEPADPP_EXE%
	::call dk_setFileAssoc .marks %NOTEPADPP_EXE%
	::call dk_setFileAssoc .md %NOTEPADPP_EXE%
	::call dk_setFileAssoc .mk %NOTEPADPP_EXE%
	::call dk_setFileAssoc .php %NOTEPADPP_EXE%
	::call dk_setFileAssoc .plist %NOTEPADPP_EXE%
	::call dk_setFileAssoc .pro %NOTEPADPP_EXE%
	::call dk_setFileAssoc .properties %NOTEPADPP_EXE%
	::call dk_setFileAssoc .ps1 %NOTEPADPP_EXE%
	::call dk_setFileAssoc .rc %NOTEPADPP_EXE%
	::call dk_setFileAssoc .reference %NOTEPADPP_EXE%
	::call dk_setFileAssoc .rsp %NOTEPADPP_EXE%
	::call dk_setFileAssoc .sed %NOTEPADPP_EXE%
	::call dk_setFileAssoc .sh %NOTEPADPP_EXE%
	::call dk_setFileAssoc .storyboard %NOTEPADPP_EXE%
	::call dk_setFileAssoc .targets %NOTEPADPP_EXE%
	::call dk_setFileAssoc .traineddata %NOTEPADPP_EXE%
	::call dk_setFileAssoc .ts %NOTEPADPP_EXE%
	::call dk_setFileAssoc .ts %NOTEPADPP_EXE%
	::call dk_setFileAssoc .txt %NOTEPADPP_EXE%
	::call dk_setFileAssoc .xml %NOTEPADPP_EXE%


	call dk_checkError
	
	:: install via CMake
::	call dk_validate DKIMPORTS_DIR dk_validateBranch
::	call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/notepadpp/DKMAKE.cmake')" "NOTEPADPP_EXE"
::	call dk_printVar NOTEPADPP_EXE
::	call dk_checkError
goto:eof



:DKTEST ########################################################################

call dk_installNotepadpp
