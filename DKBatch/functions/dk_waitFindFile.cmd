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


rem ##################################################################################
rem # dk_waitOnFileChange(<filename> <searchpath> <timeout>:optional)
rem #
:dk_waitFindFile
%setlocal%
	set "filename=%~1"
	set "searchPath=%~2"

	set /a "seconds=0"
	set /a "timeout=30"
	if "%~3" neq "" (set /a "timeout=%~3")
	
	echo Looking for %filename% in %searchPath% for %timeout% seconds. press q to skip
	:dk_waitFindFile_LOOP

		rem where /R "%searchPath%" "%filename%" 2>nul
		rem %dk_call% dk_findProgram FOUND_FILE "%filename%" "%searchPath%"
		%dk_call% dk_findFile "%filename%" "%searchPath%" FOUND_FILE

        rem file found?
        if defined FOUND_FILE (
			endlocal & (
				set "dk_waitFindFile=%FOUND_FILE%"
				%return%
			)
		)

        rem Wait for a second before checking for the file again
        CHOICE /T 1 /C "yq" /D y > nul

        rem User pressed Q? just quit
        if "%errorlevel%" neq "1" (goto :eof)

        rem Repeat until file changed, timeout elapsed, user quits or Ctrl-C
		if %seconds% gtr %timeout% (
			%clearerror%
			%return%
		)
		set /a "seconds=seconds+1"
    goto dk_waitFindFile_LOOP
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_waitFindFile "vs_setup_bootstrapper.exe" "%SystemRoot%\Temp" 60
	
	echo file found or timeout reached
%endfunction%
