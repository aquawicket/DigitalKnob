@echo off
call ../../../DKBatch/functions/DK.cmd


::####################################################################
::# dk_installNotepadpp()
::#
:dk_installNotepadpp () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	
	call dk_validate HOST_OS "dk_getHostTriple"
	
	if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"   call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"     call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"  call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip"
	
	if not defined POWERSHELL_DL goto:eof
	
	call dk_getFilename %POWERSHELL_DL% POWERSHELL_DL_FILE
	call dk_removeExtension %POWERSHELL_DL_FILE% POWERSHELL_FOLDER
	call dk_convertToCIdentifier %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	call dk_toLower %POWERSHELL_FOLDER% POWERSHELL_FOLDER

	call dk_validate DKTOOLS_DIR "dk_getDKPaths"
	call dk_set POWERSHELL "%DKTOOLS_DIR%\%POWERSHELL_FOLDER%"

	::FIXME: kill pwsh.exe peocess
	call dk_remove "%POWERSHELL%"
	
	call dk_checkError
	
	:: uninstall via CMake
::	call dk_validate DKIMPORTS_DIR dk_validateBranch
::	call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/powershell/DKMAKE.cmake')" "NOTEPADPP_EXE"
::	call dk_printVar POWERSHELL_EXE
::	call dk_checkError
goto:eof