rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # DKUNINSTALL()
rem #
:DKUNINSTALL
rem %setlocal%
	
	%dk_call% dk_validate Host_Tuple %dk_call% dk_Host_Tuple
	if defined Windows_Arm64_Host     	(set "pwsh_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-arm64.zip")
    if defined Windows_X86_Host      	(set "pwsh_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x86.zip")
    if defined Windows_X86_64_Host		(set "pwsh_Import=https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/PowerShell-7.4.2-win-x64.zip")
	if NOT defined pwsh_Import     		(%dk_call% dk_error "pwsh_Import is invalid")
	
	%dk_call% dk_basename %pwsh_Import% pwsh_Import_File
	%dk_call% dk_removeExtension %pwsh_Import_File% pwsh_Install_Name
	rem %dk_call% dk_convertToCIdentifier %pwsh_Install_Name% pwsh_Install_Name
	%dk_call% dk_toLower %pwsh_Install_Name% pwsh_Install_Name
	%dk_call% dk_validate DKTOOLS_DIR %dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_set pwsh_DIR "%DKTOOLS_DIR%\%pwsh_Install_Name%"
	
	rem FIXME: kill pwsh.exe peocess
	%dk_call% dk_delete "%pwsh_DIR%"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKUNINSTALL
%endfunction%