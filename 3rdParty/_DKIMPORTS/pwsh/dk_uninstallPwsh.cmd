@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_uninstallPwsh()
::#
:dk_uninstallPwsh
	call dk_debugFunc 0
	
	call dk_validate HOST_OS "call dk_getHostTriple"
	
	if "%HOST_OS%_%HOST_ARCH%"=="win_arm64"   call dk_set PWSH_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86"     call dk_set PWSH_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64"  call dk_set PWSH_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip"
	if not defined PWSH_DL call dk_error "PWSH_DL is invalid"
	
	call dk_basename %PWSH_DL% PWSH_DL_FILE
	call dk_removeExtension %PWSH_DL_FILE% PWSH_FOLDER
	call dk_convertToCIdentifier %PWSH_FOLDER% PWSH_FOLDER
	call dk_toLower %PWSH_FOLDER% PWSH_FOLDER

	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set PWSH_DIR "%DKTOOLS_DIR%\%PWSH_FOLDER%"

	::FIXME: kill pwsh.exe peocess
	call dk_delete "%PWSH_DIR%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_uninstallPwsh
goto:eof