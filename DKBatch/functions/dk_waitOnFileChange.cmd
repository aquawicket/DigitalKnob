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
rem # dk_waitOnFileChange(<file> <timeout>:optional)
rem #
:dk_waitOnFileChange
%setlocal%
	set "_file_=%~1"
	set "_file_=%_file_:/=\%"
	for %%a in (%_file_%) do set last_fdate=%%~ta.%%~za.%%~aa
	set /a "seconds=0"
	set /a "timeout=30"
	if "%~2" neq "" (set /a "timeout=%~2")
	
	echo Waiting for change in %_file_%.   press q to skip
	:dk_waitOnFileChange_LOOP
        rem Get the file date/time, size and attributes
        for %%a in (%_file_%) do set fdate=%%~ta.%%~za.%%~aa

        rem Different attributes found?
        if "%last_fdate%" neq "%fdate%" (%return%)

        rem Remember the new date/time
        set last_fdate=%fdate%

        rem Wait for a second before checking for the file modification again
        CHOICE /T 1 /C "yq" /D y > nul

        rem User pressed Q? just quit
        if "%errorlevel%" neq "1" )goto :eof)

        rem Repeat until file changed, timeout elapsed, user quits or Ctrl-C
		if %seconds% gtr %timeout% (
			%clearerror%
			%return%
		)
		set /a "seconds=seconds+1"
    goto dk_waitOnFileChange_LOOP
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "testFile=C:\dk_waitOnFileChange_TEST.txt"
	rem echo test > "%testFile%"
	%dk_call% dk_waitOnFileChange "%testFile%" 60
	
	echo file changed of timeout reached
%endfunction%
