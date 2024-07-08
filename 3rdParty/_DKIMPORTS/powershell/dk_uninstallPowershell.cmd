@echo off
call ..\..\..\DKBatch\functions\DK.cmd


::####################################################################
::# dk_uninstallPowershell()
::#
:dk_uninstallPowershell
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	
	call dk_validate HOST_OS "call dk_getHostTriple"
	
	if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"   call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"     call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"  call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip"
	
	if not defined POWERSHELL_DL goto:eof
	
	call dk_getBasename %POWERSHELL_DL% POWERSHELL_DL_FILE
	call dk_removeExtension %POWERSHELL_DL_FILE% POWERSHELL_FOLDER
	call dk_convertToCIdentifier %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	call dk_toLower %POWERSHELL_FOLDER% POWERSHELL_FOLDER

	call dk_validate DKTOOLS_DIR "call dk_getDKPaths"
	call dk_set POWERSHELL "%DKTOOLS_DIR%\%POWERSHELL_FOLDER%"

	::FIXME: kill pwsh.exe peocess
	call dk_remove "%POWERSHELL%"
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_uninstallPowershell
goto:eof