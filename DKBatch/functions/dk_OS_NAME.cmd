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
rem # dk_OS_NAME()
rem #
:dk_OS_NAME
%setlocal%

	%dk_call% dk_validate WMIC.exe %dk_call% dk_findFile WMIC.exe
	for /f "tokens=1* delims==" %%A in ('%WMIC.exe:/=\% os get Caption /value') do (
	for /f "tokens=*" %%S in ("%%B") do (
		if /i "%%A" equ "Caption" set "dk_OS_NAME=%%S"
	))
	
	:return
	endlocal & (
		set "dk_OS_NAME=%dk_OS_NAME%"
	)
	rem %dk_call% dk_debug "dk_OS_NAME = %dk_OS_NAME%"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_OS_NAME
	%dk_call% dk_debug "dk_OS_NAME = '%dk_OS_NAME%'"
%endfunction%
