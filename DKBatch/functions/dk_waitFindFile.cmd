@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::##################################################################################
::# dk_waitOnFileChange(<filename> <searchpath> <timeout>:optional)
::#
:dk_waitFindFile
setlocal enableDelayedExpansion
	::%dk_call% dk_debugFunc 1 2
	set "filename=%~1"
	set "searchPath=%~2"

	set /a "seconds=0"
	set /a "timeout=30"
	if not "%~3" equ "" (set /a "timeout=%~3")
	
	echo Looking for %filename% in %searchPath% for %timeout% seconds. press q to skip
	:dk_waitFindFile_LOOP

		::where /R "%searchPath%" "%filename%" 2>nul
		%dk_call% dk_findProgram FOUND_FILE "%filename%" "%searchPath%"

        :: file found?
        if defined FOUND_FILE ( 
			endlocal & (
				set "dk_waitFindFile=%FOUND_FILE%"
				%return%
			)
		)

        :: Wait for a second before checking for the file again
        CHOICE /T 1 /C "yq" /D y > nul

        :: User pressed Q? just quit
        if not "%errorlevel%" equ "1" (goto :eof)

        :: Repeat until file changed, timeout elapsed, user quits or Ctrl-C
		if %seconds% gtr %timeout% (
			(call )
			%return%
		)
		set /a "seconds=seconds+1"
    goto dk_waitFindFile_LOOP
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_waitFindFile "vs_setup_bootstrapper.exe" "C:\Windows\Temp" 60
	
	echo file found or timeout reached
%endfunction%
