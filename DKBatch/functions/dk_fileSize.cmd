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
rem # dk_fileSize(<path> <rtn_var:optional>)
rem #
rem #
:dk_fileSize
%setlocal%

	set _input=%1
	set _input=%_input:"=%
	if "%_input:~-1%" equ "\" set _input=%_input:~0,-1%
	if "%_input:~-1%" equ "/" set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "dk_fileSize=%%~zZ"
	
	:return
	endlocal & (
		set "dk_fileSize=%dk_fileSize%"
		if "%~2" neq "" (
			set "%~2=%dk_fileSize%"
		) else (
			echo %dk_fileSize%
		)
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem	%dk_call% dk_echo 
rem	%dk_call% dk_set myPath "DK.cmd"
rem	%dk_call% dk_fileSize "%myPath%"
rem	%dk_call% dk_echo "dk_fileSize = %dk_fileSize%"
	
rem	%dk_call% dk_echo 
rem	%dk_call% dk_set myPath "dk_fileSize.cmd"
rem	%dk_call% dk_fileSize "%myPath%" myFileSize
rem	%dk_call% dk_echo "dk_fileSize = %dk_fileSize%"
rem	%dk_call% dk_echo "myFileSize = %myFileSize%"
	
	%dk_call% dk_selectFile
	%dk_call% dk_fileSize "%dk_selectFile%"
%endfunction%
