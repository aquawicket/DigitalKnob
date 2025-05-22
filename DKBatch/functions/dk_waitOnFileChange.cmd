@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::##################################################################################
::# dk_waitOnFileChange(<file> <timeout>:optional)
::#
:dk_waitOnFileChange
%setlocal%
	::%dk_call% dk_debugFunc 1 2
	set "_file_=%~1"
	set "_file_=%_file_:/=\%"
	for %%a in (%_file_%) do set last_fdate=%%~ta.%%~za.%%~aa
	set /a "seconds=0"
	set /a "timeout=30"
	if "%~2" neq "" (set /a "timeout=%~2")
	
	echo Waiting for change in %_file_%.   press q to skip
	:dk_waitOnFileChange_LOOP
        :: Get the file date/time, size and attributes
        for %%a in (%_file_%) do set fdate=%%~ta.%%~za.%%~aa

        :: Different attributes found?
        if "%last_fdate%" neq "%fdate%" (%return%)

        :: Remember the new date/time
        set last_fdate=%fdate%

        :: Wait for a second before checking for the file modification again
        CHOICE /T 1 /C "yq" /D y > nul

        :: User pressed Q? just quit
        if "%errorlevel%" neq "1" )goto :eof)

        :: Repeat until file changed, timeout elapsed, user quits or Ctrl-C
		if %seconds% gtr %timeout% (
			(call )
			%return%
		)
		set /a "seconds=seconds+1"
    goto dk_waitOnFileChange_LOOP
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	set "testFile=C:\dk_waitOnFileChange_TEST.txt"
	::echo test > "%testFile%"
	%dk_call% dk_waitOnFileChange "%testFile%" 60
	
	echo file changed of timeout reached
%endfunction%
