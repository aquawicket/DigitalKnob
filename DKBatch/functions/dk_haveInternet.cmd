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


rem ##############################################################################
rem # dk_haveInternet(name, rtn_var:optional)
rem #
rem #
:dk_haveInternet
%setlocal%

	set "ping_exe=%SystemRoot:\=/%/System32/ping.exe"
    %ComSpec% /c %ping_exe% -n 1 8.8.8.8 > nul 2> nul"
    if "%errorlevel%" equ "0" (
		set "dk_haveInternet=0"
    ) else (
		set "dk_haveInternet=1"
	)
	
	:return
	endlocal & (
		set "dk_haveInternet=%dk_haveInternet%"
		if "%~2" neq "" (
			set "%~2=%dk_haveInternet%"
		) else (
			echo %dk_haveInternet%
		)
	)
	exit /b %dk_haveInternet%
%endfunction%









rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    %dk_call% dk_haveInternet && %dk_call% dk_echo "Connected" || %dk_call% dk_echo "Dissconected"
%endfunction%
