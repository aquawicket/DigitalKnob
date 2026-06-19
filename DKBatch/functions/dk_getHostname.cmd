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


rem ############################################################################
rem # dk_getHostname(ipaddress rtn_var:optional)
rem #
rem #
:dk_getHostname
%setlocal%

	set "ipaddress=%~1"
	%dk_call% dk_debug "ipaddress = %ipaddress%"
	for /f "tokens=2 delims= " %%G in ('ping -a %ipaddress% -n 1 ^| find "[%ipaddress%]"') do (set "dk_getHostname=%%G")

	:return
	endlocal & (
		set "dk_getHostname=%dk_getHostname%"
		if "%~2" neq "" (
			set "%~2=%dk_getHostname%"
		) else (
			echo %dk_getHostname%
		)
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_getHostname "8.8.8.8" hostname
	%dk_call% dk_echo "hostname = %hostname%"
	%dk_call% dk_echo "dk_getHostname = %dk_getHostname%"
%endfunction%

