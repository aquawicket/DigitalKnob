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


:main
    setlocal

	%dk_call% dk_validate DKBRANCH_DIR	%dk_call% dk_DKBRANCH_DIR
	set "file=%DKBRANCH_DIR%/TODO.txt"
	
    if NOT EXIST "%file%" (
        echo Input file:'%file%' NOT found
        goto:eof
    )
    set last_fdate=x
    title Monitoring file:'%file%'

    :repeat
        rem Get the file date/time, size and attributes
        for %%a in (%file%) do (set fdate=%%~ta.%%~za.%%~aa)

        rem Different attributes found?
        if "%last_fdate%" neq "%fdate%" (
            %dk_call% dk_clearScreen
			%dk_call% dk_echo "Monitoring %file% for changes"
			%dk_call% dk_echo "   last file info = %last_fdate%"
			%dk_call% dk_echo "current file info = %fdate%"
			%dk_call% dk_echo "press 'q' to quit"
        )

        rem Remember the new date/time
        set last_fdate=%fdate%

        rem Wait for a second before checking for the file modification again
		if NOT DEFINED choice.exe (
			set "choice.exe=C:/Windows/System32/choice.exe"
		)
        "%choice.exe:/=\%" /T 1 /C "yq" /D y > nul

        rem User pressed Q? just quit
        if "%errorlevel%" neq "1" (goto:eof)

        rem Repeat until user quits or Ctrl-C
        goto:repeat
exit /b %errorlevel%
