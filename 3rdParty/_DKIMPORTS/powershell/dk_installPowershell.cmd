@echo off
call ../../../DKBatch/functions/DK.cmd

::####################################################################
::# dk_installPowershell()
::#
:dk_installPowershell () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_validate HOST_OS "dk_getHostTriple"
	
	if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"   call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"     call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"  call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip"
	
	if not defined POWERSHELL_DL call dk_error "POWERSHELL_DL is invalid"
	
	call dk_getFilename %POWERSHELL_DL% POWERSHELL_DL_FILE
	call dk_removeExtension %POWERSHELL_DL_FILE% POWERSHELL_FOLDER
	call dk_convertToCIdentifier %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	call dk_toLower %POWERSHELL_FOLDER% POWERSHELL_FOLDER

	call dk_validate DKTOOLS_DIR "dk_getDKPaths"
	call dk_set POWERSHELL "%DKTOOLS_DIR%\%POWERSHELL_FOLDER%"
	call dk_set POWERSHELL_EXE "%POWERSHELL%\pwsh.exe"
	
	if exist "%POWERSHELL_EXE%" goto:eof
	::goto:associateFiles
	
	call dk_echo   
    call dk_info "Installing powershell . . ."
    call dk_download %POWERSHELL_DL% "%DKDOWNLOAD_DIR%\%POWERSHELL_DL_FILE%"
    call dk_smartExtract "%DKDOWNLOAD_DIR%\%POWERSHELL_DL_FILE%" "%POWERSHELL%"
	
	if NOT exist "%POWERSHELL_EXE%" call dk_error "cannot find pwsh.exe"
	

	call dk_checkError
	
	:: install via CMake
::	call dk_validate DKIMPORTS_DIR dk_validateBranch
::	call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/powershell/DKMAKE.cmake')" "POWERSHELL_EXE"
::	call dk_printVar POWERSHELL_EXE
::	call dk_checkError
goto:eof



:DKTEST ########################################################################

call dk_installPowershell
