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


:listDependencies
%setlocal%
	%dk_call% dk_validate dumpbin_exe %dk_call% dk_depend dumpbin
	
	::for /r %%a in (*.exe) do set "exe_file=%%a"
	set "exe_file=%~1"
	if "%exe_file%" equ "" (set "exe_file=C:\Windows\System32\curl.exe")
	
	
	%dk_call% dk_debug "exe_file = %exe_file%"
	"%dumpbin_exe:/=\%" /dependents %exe_file%
%endfunction%
