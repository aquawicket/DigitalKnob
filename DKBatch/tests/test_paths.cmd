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


rem # http://cplusplus.bordoon.com/cmd_exe_variables.html

:main
rem 	set IN=%0
set "IN=%SystemRoot%\NonExistent.file
rem 	set "IN=%0"
rem 	set IN=%~0
rem 	set "IN=%~0"
rem 	set "IN=%ProgramFiles%\WSL\wsl.exe"
rem 	set "IN=%USERPROFILE%\Digital Knob\Development\DKBatch\tests\test_blank.cmd"
rem 	set "IN=%ProgramFiles:\=/%/WSL/wsl.exe"
rem		set "IN=test_dk_echo.cmd"
rem 	set "IN=/test_dk_echo.cmd"
rem 	set "IN=\test_dk_echo.cmd"
rem 	set "IN=../docs.txt"
rem 	set "IN=..\docs.txt"
rem 	set "IN=..\functions\DK.cmd"
rem 	set "IN=../functions/DK.cmd"
rem 	set "IN=../functions\DK.cmd"
rem 	set "IN=..\functions/DK.cmd"
rem 	set "IN=..\\functions\\DK.cmd"
rem 	set "IN=..//functions//DK.cmd"
rem 	set "IN=..\..\DKBatch\functions\DK.cmd"
rem 	set "IN=..\..\DKBatch\..\Batch\functions\DK.cmd"
rem 	set IN=%USERPROFILE%\Digital Knob\Development\DKBatch\
rem 	set "IN=%USERPROFILE:\=/%/Digital Knob/Development/DKBatch/DK.cmd"
rem 	set "IN=%USERPROFILE%\Digital Knob\Development\DKBatch"

	echo IN         = "%IN%"

	%dk_call% dk_pathExists "%IN%"
	%dk_call% dk_pathExists "%IN%" && (echo "%IN%" exists) || (echo "%IN%" NOT FOUND)
	
	call :get_variable "%IN%" get_variable
	echo get_variable   = %get_variable%

	%dk_call% dk_getUnquoted "%IN%" dk_getUnquoted
	echo dk_getUnquoted   = %dk_getUnquoted%

	%dk_call% dk_realpath "%IN%" dk_realpath
	echo dk_realpath   = %dk_realpath%
	
	%dk_call% dk_dirname "%IN%" dk_dirname
	echo dk_dirname   = %dk_dirname%
	
	%dk_call% dk_basename "%IN%" dk_basename
	echo dk_basename   = %dk_basename%
	
	%dk_call% dk_driveName "%IN%" dk_driveName
	echo dk_driveName      = %dk_driveName%

	%dk_call% dk_getExtension "%IN%" dk_getExtension
	echo dk_getExtension  = %dk_getExtension%

	%dk_call% dk_getShortPath "%IN%" dk_getShortPath
	echo dk_getShortPath  = %dk_getShortPath%

	%dk_call% dk_getAttributes "%IN%" dk_getAttributes
	echo dk_getAttributes = %dk_getAttributes%

	%dk_call% dk_getFileTime "%IN%" dk_getFileTime
	echo dk_getFileTime   = %dk_getFileTime%

	%dk_call% dk_fileSize "%IN%" dk_fileSize
	echo dk_fileSize   = %dk_fileSize% bytes
	
%endfunction%


rem  print all variable names
rem for /f "usebackq delims==" %%i in (`set`) do @echo %%i

:get_variable
	set _input=%1
	set _input=%_input:"=%
	if "%_input:~-1%" equ "\" set _input=%_input:~0,-1%
	if "%_input:~-1%" equ "/" set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%Z"
	endlocal & (
		set %~2=%OUT%
	)
%endfunction%

