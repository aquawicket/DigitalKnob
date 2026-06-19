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


rem #####################################################################
rem # dk_Host_Os()
rem #
rem #	  Host_Os = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
rem #
:dk_Host_Os
%setlocal%

	rem ###### SET ######
	if "%~1" neq "" (
		set "Host_Os=%~1"
	
	rem ###### GET ######	
	) else (
		set "Host_Os=Windows"
	)
	
	endlocal & (
		set "Host_Os=%Host_Os%"
		set "%Host_Os%_Host=1"
	)

%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ###### GET ######
    %dk_call% dk_Host_Os
	%dk_call% dk_echo "Host_Os = %Host_Os%"
	%dk_call% dk_echo "%Host_Os%_Host = !%Host_Os%_Host!"
	
	rem ###### SET ######
	%dk_call% dk_Host_Os "Windows"
	%dk_call% dk_echo "Host_Os = %Host_Os%"
	%dk_call% dk_echo "%Host_Os%_Host = !%Host_Os%_Host!"
	
%endfunction%