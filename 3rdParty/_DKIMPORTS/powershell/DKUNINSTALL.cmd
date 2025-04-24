@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
::setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined win_arm64_host         (set "POWERSHELL_DL=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip")
    if defined win_x86_host           (set "POWERSHELL_DL=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip")
    if defined win_x86_64_host        (set "POWERSHELL_DL=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip")
	if not defined POWERSHELL_DL      (%dk_call% dk_error "POWERSHELL_DL is invalid")
	
	%dk_call% dk_basename %POWERSHELL_DL% POWERSHELL_DL_FILE
	%dk_call% dk_removeExtension %POWERSHELL_DL_FILE% POWERSHELL_FOLDER
	::%dk_call% dk_convertToCIdentifier %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	%dk_call% dk_toLower %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set POWERSHELL_DIR "%DKTOOLS_DIR%\%POWERSHELL_FOLDER%"
	
	::FIXME: kill pwsh.exe peocess
	%dk_call% dk_delete "%POWERSHELL_DIR%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKUNINSTALL
%endfunction%