@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0

::####################################################################
::# dk_uninstallPowershell()
::#
:dk_uninstallPowershell
	call dk_debugFunc 0
	
	call dk_validate DK_HOST_OS "call dk_getHostTriple"
	
	if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_arm64"   call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86"     call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip"
    if "%DK_HOST_OS%_%DK_HOST_ARCH%"=="win_x86_64"  call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip"
	if not defined POWERSHELL_DL call dk_error "POWERSHELL_DL is invalid"
	
	call dk_basename %POWERSHELL_DL% POWERSHELL_DL_FILE
	call dk_removeExtension %POWERSHELL_DL_FILE% POWERSHELL_FOLDER
	call dk_convertToCIdentifier %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	call dk_toLower %POWERSHELL_FOLDER% POWERSHELL_FOLDER

	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set POWERSHELL_DIR "%DKTOOLS_DIR%\%POWERSHELL_FOLDER%"

	::FIXME: kill pwsh.exe peocess
	call dk_delete "%POWERSHELL_DIR%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_uninstallPowershell
goto:eof