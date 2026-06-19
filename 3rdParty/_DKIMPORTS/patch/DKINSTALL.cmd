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
rem # DKINSTALL
rem #
:DKINSTALL
%setlocal%

	if EXIST "%patch_exe%" (%return%)
	
	rem ###### git patch.exe ######
	if NOT EXIST "%patch_exe%" (
		%dk_call% dk_validate git %dk_call% dk_depend git
		set "patch_exe=!git!/usr/bin/patch.exe"
	)	
	
	%dk_call% dk_assertPath patch_exe
	
	:return
	endlocal & (
		set "patch_exe=%patch_exe%"
	)
	rem %dk_call% dk_debug "patch_exe = %patch_exe%"
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate patch %dk_call% dk_depend patch
	%dk_call% dk_echo "patch_exe = %patch_exe%"
%endfunction%
