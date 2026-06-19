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
::# DKUNINSTALL()
::#
:DKUNINSTALL
::%setlocal%
	
	::%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	::%dk_call% dk_validate wsl.exe %dk_call% dk_depend wsl.exe
	
	%dk_call% dk_echo  
    %dk_call% dk_info "UnInstalling WSL-Debian Linux . . ."

	wsl --terminate Debian
	wsl --unregister Debian
	%dk_call% dk_killProcess "wslservice.exe"
	
	%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe
	%powershell.exe% -Command "Remove-AppxPackage -Package TheDebianProject.DebianGNULinux_1.12.2.0_x64__76v4gfsz19hv4"
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% DKUNINSTALL
%endfunction%
