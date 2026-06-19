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
rem # DKINSTALL()
rem #
rem #
:DKINSTALL
%setlocal%

	rem ########### from %SystemRoot%/System32 #############
	if NOT EXIST "%System32%" (
		set "System32=%SystemRoot:\=/%/System32"
	)

	rem ### Test exists
	if NOT EXIST "%System32%" (
		%dk_call% dk_notice "System32:'%System32%' NOT FOUND"
		%return%
	)

	
	:return
	endlocal & (
		set "System32=%System32%"
	)
	%dk_call% dk_debug "System32 = %System32%"
%endfunction%








rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "System32="
	
	%dk_call% dk_validate System32 %dk_call% dk_depend System32
	%dk_call% dk_echo "System32 = %System32%"
	
	%dk_call% dk_validate System32 %dk_call% dk_depend System32
	%dk_call% dk_echo "System32 = %System32%"
%endfunction%	