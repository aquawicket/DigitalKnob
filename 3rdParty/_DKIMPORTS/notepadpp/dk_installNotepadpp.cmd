@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installNotepadpp()
::#
:dk_installNotepadpp () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	
	call dk_validate HOST_OS "dk_getHostTriple"
	
	if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"   call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"     call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"  call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip"
	
	if not defined NOTEPADPP_DL call dk_error "NOTEPADPP_DL is invalid"
	
	call dk_getFilename %NOTEPADPP_DL% NOTEPADPP_DL_FILE
	call dk_removeExtension %NOTEPADPP_DL_FILE% NOTEPADPP_FOLDER
	call dk_convertToCIdentifier %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	call dk_convertToLowercase %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER

	call dk_validate DKTOOLS_DIR "dk_getDKPaths"
	call dk_set NOTEPADPP "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"
	call dk_set NOTEPADPP_EXE "%NOTEPADPP%\notepad++.exe"
	
	if exist "%NOTEPADPP_EXE%" goto:eof
	
	call dk_echo   
    call dk_info "Installing notepad++ . . ."
    call dk_download %NOTEPADPP_DL% "%DKDOWNLOAD_DIR%\%NOTEPADPP_DL_FILE%"
    call dk_smartExtract "%DKDOWNLOAD_DIR%\%NOTEPADPP_DL_FILE%" "%NOTEPADPP%"
	
	if NOT exist "%NOTEPADPP_EXE%" call dk_error "cannot find notepad++.exe"
	
	:::::: dark mode ###
	call dk_validate DKIMPORTS_DIR "dk_validateBranch"
	call dk_copy %DKIMPORTS_DIR%\notepadpp\dark_config.xml %NOTEPADPP%\config.xml OVERWRITE

	:::::: Add Context Menu
	call dk_info "Adding ^'Edit with Notepad++^' context menu to Windows..." 
	call dk_setRegistryKey "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" "Icon" "REG_SZ" "\"%NOTEPADPP_EXE%\""
	call dk_setRegistryKey "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++\command" "" "" "\"%NOTEPADPP_EXE%\" \"%%%%1\""

	:::::: associateFiles.cmd ###
	::	Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts
	::	Seems to be a better place to change file associations. They take precidence over ftype and assoc commands
	::
	:: https://ss64.com/nt/ftype.html
	ftype dk_txtfile=%NOTEPADPP_EXE% "%%1"

	assoc .1=dk_txtfile
	assoc .2=dk_txtfile
	assoc .3=dk_txtfile
	assoc .=dk_txtfile
	assoc .androidproj=dk_txtfile
	assoc .backup=dk_txtfile
	assoc .bak=dk_txtfile
	assoc .c=dk_txtfile
	assoc .cmake=dk_txtfile
	assoc .code-workspace=dk_txtfile
	assoc .cpp=dk_txtfile
	assoc .css=dk_txtfile
	assoc .data=dk_txtfile
	assoc .gitattributes=dk_txtfile
	assoc .gitconfig=dk_txtfile
	assoc .glsl=dk_txtfile
	assoc .gradle=dk_txtfile
	assoc .h=dk_txtfile
	assoc .htm=dk_txtfile
	assoc .html=dk_txtfile
	assoc .java=dk_txtfile
	assoc .js=dk_txtfile
	assoc .json=dk_txtfile
	assoc .make=dk_txtfile
	assoc .marks=dk_txtfile
	assoc .md=dk_txtfile
	assoc .mk=dk_txtfile
	assoc .php=dk_txtfile
	assoc .plist=dk_txtfile
	assoc .pro=dk_txtfile
	assoc .properties=dk_txtfile
	assoc .rc=dk_txtfile
	assoc .reference=dk_txtfile
	assoc .rsp=dk_txtfile
	assoc .sed=dk_txtfile
	assoc .sh=dk_txtfile
	assoc .storyboard=dk_txtfile
	assoc .targets=dk_txtfile
	assoc .traineddata=dk_txtfile
	assoc .ts=dk_txtfile
	assoc .ts=dk_txtfile
	assoc .txt=dk_txtfile
	assoc .xml=dk_txtfile
	

	call dk_checkError
	
	:: install via CMake
::	call dk_validate DKIMPORTS_DIR dk_validateBranch
::	call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/notepadpp/DKMAKE.cmake')" "NOTEPADPP_EXE"
::	call dk_printVar NOTEPADPP_EXE
::	call dk_checkError
goto:eof



:DKTEST ########################################################################

call dk_validate DKTOOLS_DIR "dk_getDKPaths"
call dk_set NOTEPADPP "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"
call dk_set NOTEPADPP_EXE "%NOTEPADPP%\notepad++.exe"
call dk_setRegistryKey "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++\command" " " " " "\"%NOTEPADPP_EXE%\" \"%%%%1\""
