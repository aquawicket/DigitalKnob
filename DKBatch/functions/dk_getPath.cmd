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
rem # dk_getPath(<path>, <rtn_var>:optional)
rem #
rem #    reference: https://stackoverflow.com/a/59739663/688352
rem #
:dk_getPath
%setlocal%

    set "_input=%1"
    set "_input=%_input:"=%"
	set "_input=%_input:/=\%"
    if "%_input:~-1%" equ "\" (set "_input=%_input:~0,-1%")
    for %%Z in ("%_input%") do (set "dk_getPath=%%~pZ")
	if "%dk_getPath:~-1%" equ "\" (set "dk_getPath=%dk_getPath:~0,-1%")
	
    endlocal & (
		set "dk_getPath=%dk_getPath:\=/%"
		if "%~2" neq "" (set "%~2=%dk_getPath:\=/%")
	)
%endfunction%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_set myPath "DK.cmd"
    %dk_call% dk_getPath "%myPath%"
    %dk_call% dk_printVar dk_getPath
%endfunction%
