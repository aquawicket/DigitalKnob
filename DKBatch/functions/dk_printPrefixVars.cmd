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


rem #########################################################################
rem # dk_printPrefixVars(_prefix) 
rem #
rem #	Example: dk_printPrefixVars("CMAKE_")
rem #
:dk_printPrefixVars
%setlocal%

	set "_prefix=%~1"
	
	for /F "delims=" %%z in ('set %_prefix%') do (
		for /F "tokens=1,2 delims==" %%a in ("%%z") do (
			%dk_call% dk_debug "%%a = %%b"
		)
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	
	%dk_call% dk_printPrefixVars "CMAKE"
	%dk_call% dk_printPrefixVars "DK"
%endfunction%