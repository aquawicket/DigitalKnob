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
rem # dk_fileRead(file, rtn_var)
rem #
rem #  Read lines of a file into an array
rem #
rem #  reference: https://stackoverflow.com/a/49042678
rem #
:dk_fileRead
%setlocal%

	set "_file_=%~1"

	set /a _row_=0
	for /F "usebackq delims=" %%r in ("%_file_:/=\%") do (
		set "dk_fileRead[!_row_!]=%%r"
		if "%~2" neq "" (set "%~2[!_row_!]=%%r")
		set /a _row_+=1
	)

	rem Return the array to the calling scope
	set "_SCOPE_=%~n0"
	for /F "delims=" %%a in ('set dk_fileRead[ ^& set %~2[') do (
		if "%_SCOPE_%" equ "%~n0" endlocal
		set "%%a"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_selectFile
	%dk_call% dk_fileRead "%dk_selectFile%" optionalVar
	
	rem ### Print dk_fileRead[] array
	echo.
	for /L %%i in (0,1,1000) do (
		if NOT DEFINED dk_fileRead[%%i] (goto:endfor)
        echo dk_fileRead[%%i] = '!dk_fileRead[%%i]!'
    )
	:endfor
	
	rem ### Print optionalVar[] array
	echo.
	for /L %%i in (0,1,1000) do (
		if NOT DEFINED optionalVar[%%i] (goto:endfor)
        echo optionalVar[%%i] = '!optionalVar[%%i]!'
    )
	:endfor
%endfunction%
