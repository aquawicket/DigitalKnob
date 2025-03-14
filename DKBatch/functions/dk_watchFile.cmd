@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::##################################################################################
::# dk_watchFile(file)
::#
:dk_watchFile
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1
	set "_file_=%~1"
	set "_file_=%_file_:/=\%"
	
	%dk_call% dk_assertPath "%_file_%"
	set "last_fdate=x"
	
	:watchFile_loop
        :: Get the file date/time, size and attributes
        for %%a in (%_file_%) do set fdate=%%~ta.%%~za.%%~aa

        :: Different attributes found?
        if not "%last_fdate%"=="%fdate%" (
            cls
			echo Monitoring %_file_% for changes
			echo    last file info = !last_fdate!
			echo current file info = !fdate!
			echo press 'q' to quit
        )

        :: Remember the new date/time
        set last_fdate=%fdate%

        :: Wait for a second before checking for the file modification again
        CHOICE /T 1 /C "yq" /D y > nul

        :: User pressed Q? just quit
        if not "%errorlevel%"=="1" (goto :eof)

        :: Repeat until user quits or Ctrl-C
    goto watchFile_loop
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_fileWrite %DIGITALKNOB_DIR%\watchFile.txt "testing dk_watchFile. Alter this file and save it."
	start "" "%DIGITALKNOB_DIR%\watchFile.txt"
	%dk_call% dk_watchFile %DIGITALKNOB_DIR%\watchFile.txt 
%endfunction%
