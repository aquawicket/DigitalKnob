@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


:main
    setlocal

	set "file=%USERPROFILE%\DigitalKnob\Development\TODO.txt"
	
    if "%file%" equ "" goto :help
    if NOT exist "%file%" (
        echo Input file '%file%' NOT found
        goto :eof
    )

    set FN=%file%
    set last_fdate=x

    title Monitoring file: '%FN%'

    :repeat
        :: Get the file date/time, size and attributes
        for %%a in (%FN%) do set fdate=%%~ta.%%~za.%%~aa

        :: Different attributes found?
        if "%last_fdate%" neq "%fdate%" (
            %dk_call% dk_clearScreen
			%dk_call% dk_echo "Monitoring %FN% for changes"
			%dk_call% dk_echo "   last file info = %last_fdate%"
			%dk_call% dk_echo "current file info = %fdate%"
			%dk_call% dk_echo "press 'q' to quit"
        )

        :: Remember the new date/time
        set last_fdate=%fdate%

        :: Wait for a second before checking for the file modification again
        CHOICE /T 1 /C "yq" /D y > nul

        :: User pressed Q? just quit
        if "%errorlevel%" neq "1" goto :eof

        :: Repeat until user quits or Ctrl-C
        goto repeat

:help
    echo Auto Python reinterpreter takes the input file name to autocompile as an argument
	pause
    goto :eof