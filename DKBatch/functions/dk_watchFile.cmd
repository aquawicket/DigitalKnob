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
rem # dk_watchFile(file)
rem #
:dk_watchFile
%setlocal%
	set "_file_=%~1"
	set "_file_=%_file_:/=\%"
	
	%dk_call% dk_assertPath "%_file_%"
	set "last_file_info=x"
	
	:watchFile_loop
        rem Get the file date, time, size and attributes
        for %%a in (%_file_%) do set file_info=%%~ta.%%~za.%%~aa

        rem Different file_info found?
        if "%last_file_info%" neq "%file_info%" (
            %dk_call% dk_clearScreen
			%dk_call% dk_echo "Monitoring %_file_% for changes"
			%dk_call% dk_echo "   last file info = !last_file_info!"
			%dk_call% dk_echo "current file info = !file_info!"
			%dk_call% dk_echo "press 'q' to quit"
        )

        rem Remember the new date/time
        (set last_file_info=%file_info%)

        rem Wait for a second before checking for the file modification again
		%dk_call% dk_validate choice.exe %dk_call% dk_findFile choice.exe
        "%choice.exe%" /T 1 /C "yq" /D y > nul

        rem User pressed Q? just quit
        if "%errorlevel%" neq "1" (goto :eof)

        rem Repeat until user quits or Ctrl-C
    goto:watchFile_loop
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
	%dk_call% dk_fileWrite %DIGITALKNOB_DIR%\watchFile.txt "testing dk_watchFile. Alter this file and save it."
	start "" "%DIGITALKNOB_DIR%\watchFile.txt"
	%dk_call% dk_watchFile %DIGITALKNOB_DIR%\watchFile.txt
%endfunction%
