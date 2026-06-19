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
rem # dk_processIsRunning(name, result)
rem #
rem #
:dk_processIsRunning
%setlocal%

	%dk_call% dk_validate tasklist.exe %dk_call% dk_findFile tasklist.exe
    "%tasklist.exe:/=\%" | find /i "%~1" > nul
	set "dk_processIsRunning=%ERRORLEVEL%"

	:return
	endlocal & (
		set "dk_processIsRunning=%dk_processIsRunning%"
		if "%~2" neq "" (set "%~2=%dk_processIsRunning%")
	)
	
	exit /b %dk_processIsRunning%
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "process=cmd.exe"
    %dk_call% dk_processIsRunning %process% && echo %process% is running || echo %process% is NOT running

	set "process=nonExisent"
    %dk_call% dk_processIsRunning %process% && echo %process% is running || echo %process% is NOT running
	
	set "process=cmake-gui.exe"
    %dk_call% dk_processIsRunning %process% && echo %process% is running || echo %process% is NOT running
%endfunction%
