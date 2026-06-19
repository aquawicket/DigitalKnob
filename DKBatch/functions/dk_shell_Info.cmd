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
rem # dk_shell_Info()
rem #
rem #
:dk_shell_Info
%setlocal%
	
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	if NOT defined DKSHELL_PATH (echo %PSModulePath% | %findstr.exe% %USERPROFILE% >nul && (for /f %%G IN ('where powershell.exe') do set DKSHELL_PATH=%%G))
	if NOT defined DKSHELL_PATH (set "DKSHELL_PATH=%SHELL%")
	if NOT defined DKSHELL_PATH (set "DKSHELL_PATH=%ComSpec%")
	if NOT defined DKSHELL_NAME (for %%Z in ("%DKSHELL_PATH%") do set "DKSHELL_NAME=%%~nZ")
	
	:return
	endlocal & (
		set "DKSHELL_PATH=%DKSHELL_PATH%"
		set "DKSHELL_NAME=%DKSHELL_NAME%"
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_shell_Info
	%dk_call% dk_debug "DKSHELL_NAME = %DKSHELL_NAME%"
	%dk_call% dk_debug "DKSHELL_PATH = %DKSHELL_PATH%"
%endfunction%

