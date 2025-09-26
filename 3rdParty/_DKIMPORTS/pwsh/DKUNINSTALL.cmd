@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	if defined Windows_Arm64_Host     	(set "pwsh_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip")
    if defined Windows_X86_Host      	(set "pwsh_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip")
    if defined Windows_X86_64_Host		(set "pwsh_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip")
	if NOT defined pwsh_Import     		(%dk_call% dk_error "pwsh_Import is invalid")
	
	%dk_call% dk_basename %pwsh_Import% pwsh_Import_File
	%dk_call% dk_removeExtension %pwsh_Import_File% pwsh_Install_Name
	::%dk_call% dk_convertToCIdentifier %pwsh_Install_Name% pwsh_Install_Name
	%dk_call% dk_toLower %pwsh_Install_Name% pwsh_Install_Name
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set pwsh_DIR "%DKTOOLS_DIR%\%pwsh_Install_Name%"
	
	::FIXME: kill pwsh.exe peocess
	%dk_call% dk_delete "%pwsh_DIR%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKUNINSTALL
%endfunction%