@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_uninstallPowershell()
::#
:dk_uninstallPowershell
	call dk_debugFunc 0
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined win_arm64_host         set "POWERSHELL_DL=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip"
    if defined win_x86_host           set "POWERSHELL_DL=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip"
    if defined win_x86_64_host        set "POWERSHELL_DL=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip"
	if not defined POWERSHELL_DL      %dk_call% dk_error "POWERSHELL_DL is invalid"
	
	%dk_call% dk_basename %POWERSHELL_DL% POWERSHELL_DL_FILE
	%dk_call% dk_removeExtension %POWERSHELL_DL_FILE% POWERSHELL_FOLDER
	::%dk_call% dk_convertToCIdentifier %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	%dk_call% dk_toLower %POWERSHELL_FOLDER% POWERSHELL_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_set POWERSHELL_DIR "%DKTOOLS_DIR%\%POWERSHELL_FOLDER%"
	
	::FIXME: kill pwsh.exe peocess
	%dk_call% dk_delete "%POWERSHELL_DIR%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_uninstallPowershell
%endfunction%