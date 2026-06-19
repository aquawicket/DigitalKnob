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


rem ####################################################################
rem # dk_prependArgs(variable, string)
rem #
rem #
:dk_prependArgs
%setlocal%

	%dk_call% dk_allButFirstArgs %*
	
	endlocal & (
		if defined %~1 (
			set "%~1=%dk_allButFirstArgs% !%~1!"
		) else (
			set "%~1=%dk_allButFirstArgs%"
		)
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_printVar myVar

    %dk_call% dk_prependArgs myVar abc 123
    %dk_call% dk_printVar myVar

    %dk_call% dk_prependArgs myVar def 456
    %dk_call% dk_printVar myVar
	
	%dk_call% dk_prependArgs myVar ghi 789
    %dk_call% dk_printVar myVar
%endfunction%
