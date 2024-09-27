@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallPowershell()
::#
:dk_uninstallPowershell
	call dk_debugFunc 0
	
	call dk_validate HOST_TRIPLE "call dk_HOST_TRIPLE"
	
	if "%HOST_OS%_%HOST_ARCH%"=="WIN_ARM64"   call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86"     call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip"
    if "%HOST_OS%_%HOST_ARCH%"=="WIN_X86_64"  call dk_set POWERSHELL_DL "https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip"
	if not defined POWERSHELL_DL call dk_error "POWERSHELL_DL is invalid"
	
	::::::::: POWERSHELL_DL -> TO -> POWERSHELL_DIR :::::::::::::
	call dk_basename %POWERSHELL_DL% POWERSHELL_DL_FILE
	call dk_removeExtension %POWERSHELL_DL_FILE% POWERSHELL_FOLDER
	::call dk_convertToCIdentifier %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	call dk_toLower %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	call dk_validate DKTOOLS_DIR "call dk_DKTOOLS_DIR"
	call dk_set POWERSHELL_DIR "%DKTOOLS_DIR%\%POWERSHELL_FOLDER%"
	:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	
	::FIXME: kill pwsh.exe peocess
	call dk_delete "%POWERSHELL_DIR%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_uninstallPowershell
%endfunction%