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
rem # dk_computerName(rtn_var)
rem #
rem #	Reference: https://superuser.com/a/852394
rem #
:dk_computerName
%setlocal%
	
	set "dk_computerName=%COMPUTERNAME%"
	
	if "%dk_computerName%" equ "" (
		for /f "skip=1 delims=" %%A in (
			'wmic computersystem get name'
		) do for /f "delims=" %%B in ("%%A") do set "dk_computerName=%%A"
	)
	
	:return
	endlocal & (
		set "dk_computerName=%dk_computerName%"
		if "%~1" neq "" (
			set "%~1=%dk_computerName%"
		) else (
			echo %dk_computerName%
		)
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_computerName
	%dk_call% dk_debug "dk_computerName = %dk_computerName%"
	
%endfunction%

