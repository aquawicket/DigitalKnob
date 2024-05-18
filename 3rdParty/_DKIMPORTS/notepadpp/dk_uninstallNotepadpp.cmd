@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installNotepadpp()
::#
:dk_installNotepadpp () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_validate HOST_OS "dk_getHostTriple"
	
::	if defined WIN_ARM64_HOST  (set "NOTEPADPP_DL=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip")
::	if defined WIN_X86_HOST	   (set "NOTEPADPP_DL=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip")
::	if defined WIN_X86_64_HOST (set "NOTEPADPP_DL=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip")	
	if "%HOST_ARCH%"=="arm64"  call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip"
    if "%HOST_ARCH%"=="x86"    call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip"
    if "%HOST_ARCH%"=="x86_64" call dk_set NOTEPADPP_DL "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip"
	
	if not defined NOTEPADPP_DL goto:eof
	
	call dk_getFilename %NOTEPADPP_DL% NOTEPADPP_DL_FILE
	call dk_removeExtension %NOTEPADPP_DL_FILE% NOTEPADPP_FOLDER
	call dk_convertToCIdentifier %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	call dk_convertToLowercase %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER

	call dk_validate DKTOOLS_DIR "dk_getDKPaths"
	call dk_set NOTEPADPP "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"

	::FIXME: kill notepad++.exe peocess
	call dk_remove "%NOTEPADPP%"
	
	:::::: Add Context Menu
	call dk_info "Removing Edit with Notepad++ context menu to Windows..." 
	call dk_deleteRegistryKey "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++"
	::REG ADD "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++" /v Icon /t REG_SZ /d "\"%NOTEPADPP_EXE%\"" /f
	::REG ADD "HKEY_CLASSES_ROOT\*\shell\Edit with Notepad++\command" /ve /d "\"%NOTEPADPP_EXE%\" \"%%1\"" /f

	:::::: associateFiles.cmd ###
	::	Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts
	::	Seems to be a better place to change file associations. They take precidence over ftype and assoc commands
	::
	:: https://ss64.com/nt/ftype.html
	ftype dk_txtfile=%NOTEPADPP_EXE_WINPATH% "%%1"

	assoc .1=
	assoc .2=
	assoc .3=
	assoc .=
	assoc .androidproj=
	assoc .backup=
	assoc .bak=
	assoc .c=
	assoc .cmake=
	assoc .code-workspace=
	assoc .cpp=
	assoc .css=
	assoc .data=
	assoc .gitattributes=
	assoc .gitconfig=
	assoc .glsl=
	assoc .gradle=
	assoc .h=
	assoc .htm=
	assoc .html=
	assoc .java=
	assoc .js=
	assoc .json=
	assoc .make=
	assoc .marks=
	assoc .md=
	assoc .mk=
	assoc .php=
	assoc .plist=
	assoc .pro=
	assoc .properties=
	assoc .rc=
	assoc .reference=
	assoc .rsp=
	assoc .sed=
	assoc .sh=
	assoc .storyboard=
	assoc .targets=
	assoc .traineddata=
	assoc .ts=
	assoc .ts=
	assoc .txt=
	assoc .xml=



	call dk_checkError
	
	:: install via CMake
::	call dk_validate DKIMPORTS_DIR dk_validateBranch
::	call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/notepadpp/DKMAKE.cmake')" "NOTEPADPP_EXE"
::	call dk_printVar NOTEPADPP_EXE
::	call dk_checkError
goto:eof