@rem shebang
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


rem ################################################################################
::# DK_MINGW64_BASH environment
::#
%dk_call% dk_validate msys2 %dk_call% dk_depend msys2
set "PATH=%msys2%\mingw64\bin;%msys2%\usr\bin;%PATH%"
%dk_call% dk_chdir %msys2%\mingw64

%dk_call% dk_clearScreen
%dk_call% dk_title "Digitalknob DK_MINGW64_BASH"
%dk_call% dk_info "############ DK_MINGW64_BASH environment ############"
%dk_call% dk_info ""
%msys2%/usr/bin/env MSYSTEM=MINGW64 /usr/bin/bash